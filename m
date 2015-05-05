From: broonie@kernel.org (Mark Brown)
Date: Tue, 5 May 2015 18:12:52 +0100
Subject: [PATCH V4 1/3] OPP: Redefine bindings to overcome shortcomings
In-Reply-To: <CAKohpo=09ZhXxh5Cm7Ww9Gy-AYRp9=j82tup6atVN+aOF8twdA@mail.gmail.com>
References: <cover.1430394884.git.viresh.kumar@linaro.org>
 <d225e73f183e01fa0b71e4b9248b6a19a3f7d697.1430394884.git.viresh.kumar@linaro.org>
 <20150504121209.GM15510@sirena.org.uk>
 <CAKohponRXiWbgT26=tO83jJgbteBf38ggE7mKvLCv+wFMW1cvA@mail.gmail.com>
 <20150505105714.GA22845@sirena.org.uk>
 <CAKohpo=09ZhXxh5Cm7Ww9Gy-AYRp9=j82tup6atVN+aOF8twdA@mail.gmail.com>
Message-ID: <20150505171252.GI22845@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 05, 2015 at 05:13:33PM +0530, Viresh Kumar wrote:
> On 5 May 2015 at 16:27, Mark Brown <broonie@kernel.org> wrote:

> > No, it doesn't - you're not answering the question about what this is
> > for.

> I don't know how this information will be used finally. Probably the
> platform driver will do the configuration based on the volt-cur pair.

I don't think we should be defining a binding without understanding what
it is supposed to mean.  

>  - opp-microamp: current in micro Amperes. It can contain entries for multiple
> -  regulators.
> +  regulators. This can be referenced (along with voltage and freqency) while
> +  programming the regulator.

This still doesn't say what the value is supposed to mean which means
it's not possible for someone to write generic code which handles the
binding - saying that people can reference the value doesn't tell them
how to interpret it.  A limit?  A nominal constant draw value?  A value
to regulate to?  Those are all different things expressed as a current.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150505/6b7a3b0d/attachment.sig>
