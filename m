From: peppe.cavallaro@st.com (Giuseppe CAVALLARO)
Date: Wed, 9 Mar 2016 11:27:42 +0100
Subject: [PATCH v3 0/8] arm64: rockchip: Initial GeekBox enablement
In-Reply-To: <56DFF253.9050208@st.com>
References: <1457294038-14243-1-git-send-email-afaerber@suse.de>
 <56DD7172.4000707@suse.de> <2714888.1DdqvJZ8cb@diego>
 <56DD7593.5060003@suse.de> <56DD8176.2080603@st.com>
 <56DD8FBE.9010200@suse.de> <56DD99A4.5030004@st.com>
 <56DDA26C.3050301@suse.de> <56DDA3D5.3090209@st.com>
 <56DDB749.1020808@suse.de>
 <CADhT+wfO8x4En78g5ixnnwbpaeXJGDo+Q1sOABYsbXzNZy0CPw@mail.gmail.com>
 <56DE7E1D.5070508@st.com>
 <CADhT+weKf+F98uxCQhRa2RfMm8+4p=rrNZc-Vf=w_HPycXto=A@mail.gmail.com>
 <CAAObsKD9HoEbtV_JMz_R=bcrQseDmhncRAWP9k8djksL-LMQqw@mail.gmail.com>
 <56DFE55B.2090806@st.com> <56DFE64B.8060606@st.com>
 <CAAObsKBr9SXg1-wr9O-ypR8JozdGpeAwfDLMeUKi8ozxkKyTXg@mail.gmail.com>
 <56DFF253.9050208@st.com>
Message-ID: <56DFFA9E.7060602@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Tomeu, Andreas,

On 3/9/2016 10:52 AM, Giuseppe CAVALLARO wrote:
>> * today's linux-next: probe failed
>>
>> * today's linux-next + revert of 88f8b1bb41c6 stmmac: Fix 'eth0: No
>> PHY found' regression: probe succeeded but no network at all
>>
>> * today's linux-next + revert of 88f8b1bb41c6 (stmmac: Fix 'eth0: No
>> PHY found' regression) + revert of 0e80bdc9a72d (stmmac: first frame
>> prep at the end of xmit routine): probe succeeded, dhcp succeeds and
>> nfsroot works for a few seconds before timing out
>
> ok, I was looking at this problem now that seems to related
> the "stmmac: first frame prep at the end of xmit routine"
> that, at first glance, is breaking the gmac 3.50 with normal descriptor.

I have no Hw where to test this use case. So, I wonder if may I ask you 
to test some patch.

This first patch adds a missing barrier to the normal routine that inits 
the descriptor. Barrier was needed to well manage the OWN
descriptor and it was not added in case of normal desc case after
the xmit rework.

Then I will check the algo behind the new xmit and in case of problems,
if you agree, we will decide to revert it because it aimed to add an
optimization.

Let me know if you agree.

Regards
Peppe
-------------- next part --------------
A non-text attachment was scrubbed...
Name: normal_tmp.patch
Type: text/x-patch
Size: 950 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160309/807d1599/attachment-0001.bin>
