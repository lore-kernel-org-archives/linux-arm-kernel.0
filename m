From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 19 Apr 2010 19:18:42 -0600
Subject: [PATCHv5 2.6.34-rc4 4/5] mxc: Add generic USB HW initialization
	for MX51
In-Reply-To: <20100420011302.GJ30801@buzzloop.caiaq.de>
References: <1271716024-22990-1-git-send-email-Dinh.Nguyen@freescale.com>
	<1271716024-22990-2-git-send-email-Dinh.Nguyen@freescale.com>
	<1271716024-22990-3-git-send-email-Dinh.Nguyen@freescale.com>
	<1271716024-22990-4-git-send-email-Dinh.Nguyen@freescale.com>
	<20100420011302.GJ30801@buzzloop.caiaq.de>
Message-ID: <y2gfa686aa41004191818o126cc59cs7b551103b91f2266@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 19, 2010 at 7:13 PM, Daniel Mack <daniel@caiaq.de> wrote:
> On Mon, Apr 19, 2010 at 05:27:03PM -0500, Dinh.Nguyen at freescale.com wrote:
>> + ? ? ? ? ? ? /* allow controller to reset, and leave time for
>> + ? ? ? ? ? ? ?* the ULPI transceiver to reset too.
>> + ? ? ? ? ? ? ?*/
>> + ? ? ? ? ? ? msleep(100);
>
> Does the sleep really need to be that long? You're holding off the
> kernel's by that. If we can reduce that, we should certainly do so.

msleep() should be fine since Linux will schedule something else.
mdelay(100) would be bad indeed.

g.
