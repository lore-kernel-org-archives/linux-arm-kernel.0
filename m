From: peppe.cavallaro@st.com (Giuseppe CAVALLARO)
Date: Tue, 8 Mar 2016 08:24:13 +0100
Subject: [PATCH v3 0/8] arm64: rockchip: Initial GeekBox enablement
In-Reply-To: <CADhT+wfO8x4En78g5ixnnwbpaeXJGDo+Q1sOABYsbXzNZy0CPw@mail.gmail.com>
References: <1457294038-14243-1-git-send-email-afaerber@suse.de>	<56DD7172.4000707@suse.de>	<2714888.1DdqvJZ8cb@diego>	<56DD7593.5060003@suse.de>	<56DD8176.2080603@st.com>	<56DD8FBE.9010200@suse.de>	<56DD99A4.5030004@st.com>	<56DDA26C.3050301@suse.de>	<56DDA3D5.3090209@st.com>	<56DDB749.1020808@suse.de>
 <CADhT+wfO8x4En78g5ixnnwbpaeXJGDo+Q1sOABYsbXzNZy0CPw@mail.gmail.com>
Message-ID: <56DE7E1D.5070508@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dinh,

On 3/8/2016 12:22 AM, Dinh Nguyen wrote:
[snip]
>
> I'm seeing the same issue on the SoCFPGA platform:
>
> libphy: PHY stmmac-0:ffffffff not found
> eth0: Could not attach to PHY
> stmmac_open: Cannot attach to PHY (error: -19)
>
> If I just revert:
>
>   "stmmac: Fix 'eth0: No PHY found' regression"
>
> then the issue goes away.

do you have this patch "stmmac: first frame prep at the end of xmit 
routine" ? Or you just reverted
   "stmmac: Fix 'eth0: No PHY found' regression"

maybe we can sum:

   "stmmac: Fix 'eth0: No PHY found' regression"
            that is introducing a problem when a box
            has a transceiver

  "stmmac: first frame prep at the end of xmit routine"
            That is breaking the tx path on arm64

I will check both patches on my side and let you know

peppe

>
> Thanks,
> Dinh
>
