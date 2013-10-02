From: broonie@kernel.org (Mark Brown)
Date: Wed, 2 Oct 2013 11:35:14 +0100
Subject: [PATCH 09/10] pwm-backlight: Use an optional power supply
In-Reply-To: <20131001213120.GG9201@ulmo.nvidia.com>
References: <1379972467-11243-1-git-send-email-treding@nvidia.com>
 <1379972467-11243-10-git-send-email-treding@nvidia.com>
 <524B17ED.1080806@wwwdotorg.org>
 <20131001205310.GD9201@ulmo.nvidia.com>
 <524B37BF.2090300@wwwdotorg.org>
 <20131001213120.GG9201@ulmo.nvidia.com>
Message-ID: <20131002103514.GB4228@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 01, 2013 at 11:31:27PM +0200, Thierry Reding wrote:
> On Tue, Oct 01, 2013 at 02:59:43PM -0600, Stephen Warren wrote:

> > OK, hopefully it (the regulator core) complains about the missing DT
> > property though; I assume you're using regulator_get() not
> > regulator_get_optional(), since the supply really is not optional.

> It doesn't always. There's a pr_warn() in _regulator_get(), but that's
> only for non-DT (since for DT, has_full_constraints is set to true in
> regulator_init_complete()). Actually that would mean that the regulator
> core will complain as long as init isn't complete. But since, like many
> other drivers, pwm-backlight could use deferred probing it's likely to
> end up being probed after init.

So, part of the thing here is that nobody ever bothers actually creating
the supplies even when the device fails to load without them - everyone
is much more keen to complain about needing to do the work than actually
provide the hookup even though it's generally pretty quick and simple to
do so.

That said we probably should still moan, I'll go and do that.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131002/7c6b3a82/attachment.sig>
