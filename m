From: wsa@the-dreams.de (Wolfram Sang)
Date: Sat, 15 Feb 2014 15:44:53 +0100
Subject: [PATCH 2/5] i2c: mv64xxx: refactor message start to ensure
 proper initialization
In-Reply-To: <52FE0056.2030706@free-electrons.com>
References: <20140213094117.GA3934@katana>
 <1392323793-4125-1-git-send-email-wsa@the-dreams.de>
 <1392323793-4125-3-git-send-email-wsa@the-dreams.de>
 <52FE0056.2030706@free-electrons.com>
Message-ID: <20140215144453.GB2579@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 14, 2014 at 12:39:02PM +0100, Gregory CLEMENT wrote:
> On 13/02/2014 21:36, Wolfram Sang wrote:
> > Because the offload mechanism can fall back to a standard transfer,
> > having two seperate initialization states is unfortunate. Let's just
> > have one state which does things consistently. This fixes a bug where
> > some preparation was missing when the fallback happened. And it makes
> > the code much easier to follow.
> > 
> > Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> 
> 
> Tested-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> 
> With this one the bug we observed was fixed.

I squashed patches 1+2 (easier handling for stable) and applied to
for-current, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140215/5266b037/attachment.sig>
