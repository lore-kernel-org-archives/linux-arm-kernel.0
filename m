From: peter.griffin@linaro.org (Peter Griffin)
Date: Tue, 7 Jun 2016 09:42:08 +0100
Subject: [STLinux Kernel] [PATCH 0/7] reset: Consumers to explicitly
 request 'exclusive' or 'shared' lines
In-Reply-To: <20160606155655.10860-1-lee.jones@linaro.org>
References: <20160606155655.10860-1-lee.jones@linaro.org>
Message-ID: <20160607084208.GB22960@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, 06 Jun 2016, Lee Jones wrote:

> Phasing out generic reset line requests enables us to make some better
> decisions on when and how to (de)assert said lines.  If an 'exclusive'
> line is requested, we know a device *requires* a reset and that it's
> preferable to act upon a request right away.  However, if a 'shared'
> reset line is requested, we can reasonably assume sure that placing a
> device into reset isn't a hard requirement, but probably a measure to
> save power and is thus able to cope with not being asserted if another
> device is still in use.
> 
> In order allow gentle adoption and not to forcing all consumers to
> move to the API immediately, causing administration headache between
> subsystems, this patch adds some temporary stand-in shim-calls.  This
> will ease the burden at merge time and allow subsystems to migrate over
> to the new API in a more realistic time-frame.

Is the intention that this series will be taken into the next -rc?

As the introduction of shared resets in reset subsystem has caused regressions
on STi platforms.

regards,

Peter.
