From: peppe.cavallaro@st.com (Giuseppe CAVALLARO)
Date: Tue, 15 Mar 2016 13:36:59 +0100
Subject: [PATCH v3 0/8] arm64: rockchip: Initial GeekBox enablement
In-Reply-To: <CAAObsKCdk+6HdzFYxRKZbPiaKcfMCLjbpngurat47YvyvSgH-w@mail.gmail.com>
References: <1457294038-14243-1-git-send-email-afaerber@suse.de>
 <56DDA3D5.3090209@st.com> <56DDB749.1020808@suse.de>
 <CADhT+wfO8x4En78g5ixnnwbpaeXJGDo+Q1sOABYsbXzNZy0CPw@mail.gmail.com>
 <56DE7E1D.5070508@st.com>
 <CADhT+weKf+F98uxCQhRa2RfMm8+4p=rrNZc-Vf=w_HPycXto=A@mail.gmail.com>
 <CAAObsKD9HoEbtV_JMz_R=bcrQseDmhncRAWP9k8djksL-LMQqw@mail.gmail.com>
 <56DFE55B.2090806@st.com> <56DFE64B.8060606@st.com>
 <CAAObsKBr9SXg1-wr9O-ypR8JozdGpeAwfDLMeUKi8ozxkKyTXg@mail.gmail.com>
 <56DFF253.9050208@st.com> <56DFFA9E.7060602@st.com>
 <CAAObsKBUzBXcamEyup44N1bYUzGr_ZZTsYcD5x3PXb-2E00cGA@mail.gmail.com>
 <56E033C8.40506@st.com> <56E038CE.606@st.com>
 <CADhT+wcMpzA_Coj8Z5OQZsc3bF3a7yOmsbazQMPtcdUWkJSuCA@mail.gmail.com>
 <56E13AAB.2080900@st.com>
 <CADhT+wd=vcph2y_OxkGNO5EwHvN=kBy-BrfZHmNjZHww4LxmTg@mail.gmail.com>
 <56E28B5D.6000708@st.com>
 <CAAObsKB-tSCu5KMYk2Zi-oX9zMKEOwwT93sMkiZKiYvtexmHaQ@mail.gmail.com>
 <56E6E4B0.8060408@st.com>
 <CAAObsKCdk+6HdzFYxRKZbPiaKcfMCLjbpngurat47YvyvSgH-w@mail.gmail.com>
Message-ID: <56E801EB.6030107@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Tomeu

On 3/15/2016 8:23 AM, Tomeu Vizoso wrote:
> Thanks.
>
> Btw, I have rebased on top of 4.5 this morning and I have noticed that
> 88f8b1bb41c6 ("stmmac: Fix 'eth0: No PHY found' regression") got in
> there, so I guess we have now a bunch of boards with broken network on
> that release:(


This is the status on my side: I am testing on an HW that has the
Enhanced descriptors and all works fine.

On this HW, if I force the driver to use the normal descriptor
layout, I meet problems but using both net.git and net-next.
So I suspect I cannot ply with this HW forcing the normal descriptors.
But! That is helping me to check if, on net-next, the stmmac is
actually  programming fine the normal desc case.
I have just found another fix so I kindly ask you to apply the temp
patch  attached and let me know.
In details, I have noticed that the OWN bit was not set in the right
TDES0.

I also ask you to give me a log of the kernel where the stmmac was
running fine. I would like to see which configuration it is selected
at runtime by the driver on your box.
 From your previous logs (where the stmmac failed), it seems that
the  problem is on normal desc but, to be honest, this is the first
case I see a 3.50a with HW capability register and w/o Enhanced
descriptors.

Best Regards
Peppe

> Regards,
>
> Tomeu

-------------- next part --------------
A non-text attachment was scrubbed...
Name: tmp.patch
Type: text/x-patch
Size: 542 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160315/143d261f/attachment-0001.bin>
