From: broonie@kernel.org (Mark Brown)
Date: Tue, 12 May 2015 20:41:34 +0100
Subject: [PATCH V4 1/3] OPP: Redefine bindings to overcome shortcomings
In-Reply-To: <5552510B.9010306@ti.com>
References: <CAKohpo=kJs076afzERPMqjELgwpN6nR2yoyEjW6XY7YSEbRuCA@mail.gmail.com>
 <20150507055231.GB32399@codeaurora.org>
 <20150507110233.GR15510@sirena.org.uk>
 <20150507211855.GA2455@codeaurora.org>
 <20150507221842.GW22845@sirena.org.uk>
 <CAKohpomU8wm0T=A7EkosdOjXbP8q2Cb726Hsjh08KTKYjoz3-A@mail.gmail.com>
 <555000B6.2010107@ti.com> <20150512052033.GC32300@linux>
 <20150512190134.16410.89041@quantum> <5552510B.9010306@ti.com>
Message-ID: <20150512194134.GC3066@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 12, 2015 at 02:14:19PM -0500, Nishanth Menon wrote:

> While TWLxx series was kind of nascent in it's ability of choosing
> PWM/PFM or auto mode depending on the current targets, newer PMICs
> have their own unique techniques -> but, that said, this is a
> description of power consumption for a given OPP for the "device", How
> would stephen's case work with a PMIC and 2 devices which have
> different leakage characteristics (based on which end of the process
> spectrum they come from), Lets take an example:
> device X consumes 800mA for OPPx
> device Y consumes 900mA for OPPy

The system integrator would need to be somewhat conservative when
specifying the currents involved.  For plausible applications these are
likely to be ballpark figures rather than anything too accurate - if
nothing else the instantaneous current draw normally varies very
substantially so realistically you're talking about a maximum here.  If
the corners vary that dramatically then I'd expect you'd see different
OPP tables being used anyway.

> It is a lot more impactful than using relative numbers for other
> purposes - for example energy aware scheduling as an example -> here
> the actuals might have better optimization, but hints of relative
> power numbers by itself is pretty powerful information to help
> scheduling. The usage, in this case, unlike the usage for a PMIC
> efficiency selection, is not based on absolutes and is meant more of a
> hint (closer to usage such as clock transition latency numbers).

You're not comparing two similar types of object here, you're trying to
provide information on an actual physical value to get fed into other
actual physical values.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150512/fec87ce5/attachment.sig>
