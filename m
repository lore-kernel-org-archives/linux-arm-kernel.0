From: dinh.linux@gmail.com (Dinh Nguyen)
Date: Mon, 7 Mar 2016 17:22:24 -0600
Subject: [PATCH v3 0/8] arm64: rockchip: Initial GeekBox enablement
In-Reply-To: <56DDB749.1020808@suse.de>
References: <1457294038-14243-1-git-send-email-afaerber@suse.de>
 <56DD7172.4000707@suse.de> <2714888.1DdqvJZ8cb@diego>
 <56DD7593.5060003@suse.de> <56DD8176.2080603@st.com>
 <56DD8FBE.9010200@suse.de> <56DD99A4.5030004@st.com>
 <56DDA26C.3050301@suse.de> <56DDA3D5.3090209@st.com>
 <56DDB749.1020808@suse.de>
Message-ID: <CADhT+wfO8x4En78g5ixnnwbpaeXJGDo+Q1sOABYsbXzNZy0CPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 7, 2016 at 11:15 AM, Andreas F?rber <afaerber@suse.de> wrote:
> Am 07.03.2016 um 16:52 schrieb Giuseppe CAVALLARO:
>> On 3/7/2016 4:46 PM, Andreas F?rber wrote:
>>> Am 07.03.2016 um 16:09 schrieb Giuseppe CAVALLARO:
>>>> On 3/7/2016 3:27 PM, Andreas F?rber wrote:
>>>>> Indeed, reverting Gabriel's commit fixes the observed error messages
>>> [...]
>>>>> However, I am unable to ping any hosts on the network now.
>>>>
>>>> hmm, this could be another problem. I wonder if you can
>>>> check which recent patch is introducing the problem on ARM64.
>>>> For example if this depends on Oct_2015 update.
>>>
>>> I've had success reverting drivers/net/ethernet/stmicro/ up to and
>>> including "stmmac: first frame prep at the end of xmit routine", i.e.
>>> top 7 commits.
>>
>> Andreas, I will check it and let you know asap.
>
> I verified that it's just these two commits that I need to revert:
>
> "stmmac: Fix 'eth0: No PHY found' regression"
> "stmmac: first frame prep at the end of xmit routine"
>
> Those in between don't cause conflicts and seem to work okay.
>

I'm seeing the same issue on the SoCFPGA platform:

libphy: PHY stmmac-0:ffffffff not found
eth0: Could not attach to PHY
stmmac_open: Cannot attach to PHY (error: -19)

If I just revert:

 "stmmac: Fix 'eth0: No PHY found' regression"

then the issue goes away.

Thanks,
Dinh
