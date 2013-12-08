From: peter.maydell@linaro.org (Peter Maydell)
Date: Sun, 8 Dec 2013 16:38:58 +0000
Subject: [PATCH] ARM: cpu: Document and tweak clock-frequency property
In-Reply-To: <20131208161922.GK29268@sirena.org.uk>
References: <1386331027-26065-1-git-send-email-broonie@kernel.org>
 <52A36AB3.6060102@gmail.com> <20131208161922.GK29268@sirena.org.uk>
Message-ID: <CAFEAcA8qsb0f_5dVbytCD3fGQdT+W4=PJudCY1f-ee4Pwm=0=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 December 2013 16:19, Mark Brown <broonie@kernel.org> wrote:
> On Sat, Dec 07, 2013 at 12:36:35PM -0600, Rob Herring wrote:
>> On 12/06/2013 05:57 AM, Mark Brown wrote:
>
>> > +   - clock-frequency
>> > +           Usage: required
>
>> This breaks compatibility. It may be required for a feature in the
>
> It doesn't, it's listed as mandatory in ePAPR section 3.7.1 which is
> already part of our bindings - this is merely copying that information
> into the binding document in the kernel so that it's more discoverable
> and so that we can tweak the definition to reflect reality a bit more
> closely.

Sorry, but there is already shipping software (kvmtool
and QEMU) which isn't emitting clock-frequency properties
for cpu nodes, based on what you documented in the kernel
doc file, which says:
"The ARM architecture, in accordance with the ePAPR, requires
the cpus and cpu nodes to be present and contain the properties
described below."

not "must contain the properties described below and also
any others that the ePAPR spec says are mandatory".

So I'm afraid you're stuck with this being an optional property.

(It's also not at all clear what a virtual machine's devicetree
should set the clock-frequency properties to anyway...)

thanks
-- PMM
