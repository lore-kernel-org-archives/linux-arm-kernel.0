From: robherring2@gmail.com (Rob Herring)
Date: Wed, 23 Oct 2013 18:02:39 -0500
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution, or
 is there something better?
In-Reply-To: <CAFEAcA8rPn7x8W4T3qE5OUeSVQd-GB9+EQPnxMsmyNQ0HKoMPw@mail.gmail.com>
References: <52644A9E.3060007@wwwdotorg.org>
 <CAHCPf3uKp-aEavjrEbHGBc_Ga-JgJoEDF+io4kOuvtL6H05eRA@mail.gmail.com>
 <CAFEAcA8rPn7x8W4T3qE5OUeSVQd-GB9+EQPnxMsmyNQ0HKoMPw@mail.gmail.com>
Message-ID: <CAL_JsqLknd9jwUdD-au_f5cvOAJJyuitq0wOATWU2uids8q7Xg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 23, 2013 at 6:41 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 22 October 2013 22:44, Matt Sealey <neko@bakuhatsu.net> wrote:
>> Any driver that fails probing for an optional property is
>> broken and needs fixing.
>
> I agree, but I note that by this rule all the primecell peripheral
> drivers are broken, because the binding docs say that the
> "clocks" and "clock-names" properties are optional but if you
> omit them from the dt node then the kernel refuses to even
> call the driver's probe code. (This is specifically irritating for
> QEMU because it means we have to create a dummy clock
> node in our device tree just to placate the kernel sufficiently
> that we can get it to talk to a PL011 UART model.)

I agree this is broken. The amba bus code should allow for
non-existent clocks. I thought it did, but maybe this changed or my
memory is just broken as well.

Rob
