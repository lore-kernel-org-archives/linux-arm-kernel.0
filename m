From: balbi@ti.com (Felipe Balbi)
Date: Mon, 2 Jul 2012 14:37:13 +0300
Subject: [PATCH v2 00/17] Big OMAP I2C Cleanup
In-Reply-To: <4FE99432.8030300@ti.com>
References: <1339691067-919-1-git-send-email-balbi@ti.com>
 <20120614175950.GE14419@pengutronix.de> <4FE99432.8030300@ti.com>
Message-ID: <20120702113712.GB2730@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jun 26, 2012 at 04:21:30PM +0530, Shubhrajyoti wrote:
> On Thursday 14 June 2012 11:29 PM, Wolfram Sang wrote:
> >> 	- removed dev_err() which was introduced on patch 09/17
> > To prevent the list being flooded, I would appreciate if you could wait
> > a few days to collect reviews before resending. It will take some time
> > until I pick this series anyhow, because I want people to have time to
> > donate Tested-by tags.
> Felipe thats a good cleanup.
> The series look good to me.
> 
> Also draining interrupt I had some queries.
> Looks good to me.
> 
> I have tested it after rebasing.

rebasing on top of what ? You should resend the series so that I know
what changes you have made to my original patchset. Make sure to list on
the commit log what where the changes you made, so that it looks
something like this commit below where I changed commit log a bit:

| commit 3daf74d78dfcd552445c35f1b82a271ca305ceb9
| Author: Pratyush Anand <pratyush.anand@st.com>
| Date:   Sat Jun 23 02:23:08 2012 +0530
| 
| usb: dwc3: remove WARN_ON from dwc_stop_active_transfer
| 
| Now we are sure that, if res_trans_idx is zero, then endpoint has been
| stopped. So it's safe to just return if endpoint is already stopped. No
| need to generate warning anymore.
| 
| While doing so, it's better to return when res_trans_idx is zero and
| decrease one level of indentation.
| 
| Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
| 
| [ balbi at ti.com: slightly changed commit log ]
| 
| Signed-off-by: Felipe Balbi <balbi@ti.com>

> Tested-by : Shubhrajyoti <shubhrajyoti@ti.com>

since you will send, you should, probably, add your Signed-off-by,
instead of Tested-by. dunno.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120702/1c9edd9a/attachment.sig>
