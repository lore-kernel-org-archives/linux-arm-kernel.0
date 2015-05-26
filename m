From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Tue, 26 May 2015 08:17:23 +0200
Subject: [PATCH 10/21] regulator: core: Probe regulators on demand
In-Reply-To: <20150525173244.GE21577@sirena.org.uk>
References: <1432565608-26036-1-git-send-email-tomeu.vizoso@collabora.com>
 <1432565608-26036-11-git-send-email-tomeu.vizoso@collabora.com>
 <20150525173244.GE21577@sirena.org.uk>
Message-ID: <CAAObsKDzKzYAx4_xsNm0reXzgSrJi7Q+aZGifmVxvSEQ=Qxjkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 May 2015 at 19:32, Mark Brown <broonie@kernel.org> wrote:
> On Mon, May 25, 2015 at 04:53:14PM +0200, Tomeu Vizoso wrote:
>
>> When looking up a regulator through its DT node, ensure that the
>> corresponding device has been registered.
>
> I'm sorry but I'm going to need a much better changelog to review this
> patch.  I can't entirely tell what the intended effect is supposed to
> be, the subject line says we're probing things and the body says we're
> registering things which aren't the same thing at all.

Agreed, it would be more appropriate to say that we are registering
devices, I will make it clearer in the next revision. It ends up
probing the device at that point because we have made sure with an
earlier patch that all built-in drivers have been registered already.

>>               if (node) {
>> +                     of_platform_device_ensure(node);
>
> This function doesn't appear in git so I'm guessing that some other
> patch in the series adds it.  See my reply to the first patch...

Sorry about that, the series touches so many subsystems that I would
have reached the maximum number of recipients on the mailing lists I'm
sending it to. I will send it next with you and Krzysztof on CC on the
whole series.

> The obvious questions here based on the name are why we're doing
> something specific to platform devices and why this isn't something
> we're abstracting in the driver core (or at least generic firmware code)
> - we're going to have the same thing with ACPI.

I don't know how useful this is going to be in systems with ACPI. My
experience is limited to 32bit ARM, where the kernel has to manage
every regulator, clock, gpio, etc so the dependency tree is so big. Is
deferred probing a problem with ACPI as well?

Thanks,

Tomeu
