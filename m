From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 23 Nov 2015 10:45:50 +0100
Subject: [PATCH RESEND] pwm: ftm: fix clock enable/disable when using PM
In-Reply-To: <290ed017061ef41e1fe5c3fd5a523511@agner.ch>
References: <1445142552-3530-1-git-send-email-stefan@agner.ch>
 <290ed017061ef41e1fe5c3fd5a523511@agner.ch>
Message-ID: <20151123094550.GA28740@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 18, 2015 at 06:04:12PM -0800, Stefan Agner wrote:
> Thierry,
> 
> I realized that this patch did not make it into 4.4-rc1, while others,
> IMHO less important patches which have been posted later (e.g. sunxi
> whitespace fixes) have made it! :-(

The reason why I merged them is because they are low-risk, whereas this
patch of yours changes existing behaviour, and hasn't received any
feedback from anyone. So the choice that I need to make is to either
trust the original author to have tested the driver and it was working,
or you to have verified that it is still working after the patch on all
setups that it used to work on. The first option obviously carries the
least risk, and that's the reason why the patch hasn't been merged.

> Anything wrong with that? Or am I on your spam list? Note that this is
> already a RESEND :-)

If you want to get this merged, you should try to get some feedback from
at least the original author. Xiubo Li and I extensively discussed this
back at the time when he submitted the driver and we came up with the
current code as the best approach to making sure that clocks are on and
off when they should be. So if it's not working for you, I'm fine taking
the patch if Xiubo or somebody else has had the chance to look at it and
review or test it. So a Reviewed-by or Tested-by tag will go a long way
to convince me that it's safe to apply.

Also you enumerate all the various bits that are broken, and it would
seem to me that they could each be fixed individually rather than go and
implement something completely different which might have undesirable
side-effects. Such an approach would also make it more likely for me to
merge the patch because it would hopefully be more obvious what is being
fixed and that it's a correct fix.

It's not that I mind the rework, but I'd at least like for someone to
verify that it's all still working on existing setups. Now, I understand
that people can go missing, so if nobody were to give you a Reviewed-by
or Tested-by for a couple of weeks I'd even consider applying without,
but as it is, you didn't even Cc Xiubo on the patch, so he's likely
missed it entirely.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151123/de71099e/attachment.sig>
