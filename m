From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 20 Aug 2012 15:53:33 -0300
Subject: [PATCH] ARM: Kirkwood: Iomega IX2-200 Device Tree Support Patch
 v2 Signed-off-by: Alan M Butler <alanbutty12@gmail.com>
In-Reply-To: <CADhrpJ56iWZnBKf6Knoqbm6iucrXMb7ESDtB8WSyWbCxO6A4rg@mail.gmail.com>
References: <cover.1345196553.git.alanbutty12@gmail.com>
 <05c3c186d3675cde472bcc3a01198b6726c48a3c.1345196553.git.alanbutty12@gmail.com>
 <20120819020607.GZ22226@titan.lakedaemon.net>
 <CADhrpJ5WX-ZR3vxwe92Rg4R9a1+79Vf-QxKdJhyaC87o8HJYrw@mail.gmail.com>
 <CADhrpJ6HmUd86zx6Az0bx9JiiYp6kMmTis6ARMWBrNqoK8aKng@mail.gmail.com>
 <CAOMZO5AZZwQS8rkvrG3Nd7KAhgh3+PcfkdoKiqRW95eaUyTghg@mail.gmail.com>
 <CADhrpJ7ZE=L25V8sKyQAT02iDuyCRwyCAjw4ukopek1i0TRqNw@mail.gmail.com>
 <CAOMZO5BoWyGzB3p11yE9NXAXq319oi0bnbFuwxvahCqGDOZKrw@mail.gmail.com>
 <CADhrpJ487cN23gRkws1Grp+SEmrKO2JdDT0r-DVeCZm-XqdP=A@mail.gmail.com>
 <CAOMZO5BbdT2CXHh4NEt8bPZ4C7Mg=Yd9C9E7J2H_JsGJ=88fqQ@mail.gmail.com>
 <CADhrpJ7Fq0FktNN-54++39=SN_GrkX7gpse+2QfD7ioQw+_cEA@mail.gmail.com>
 <CADhrpJ56iWZnBKf6Knoqbm6iucrXMb7ESDtB8WSyWbCxO6A4rg@mail.gmail.com>
Message-ID: <CAOMZO5ApRi6uF1ByNzudSM9VaRNhWy4Pa1AJ-G976NezReG3WA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alan,

On Mon, Aug 20, 2012 at 2:37 PM, Alan M Butler <alanbutty12@gmail.com> wrote:

> i just tried your patch again with the latest linux-next dated 20th of
> august with that patch you gave me and i am still getting the errors
> on the gpio-keys this is the error:
>
> [    4.838988] orion_gpio_is_valid: invalid GPIO 0
> [    4.838999] orion_gpio_is_valid: invalid GPIO 0
> [    4.839015] gpio-keys gpio-keys.2: Failed to request GPIO 0, error -22
> [    4.845617] gpio-keys: probe of gpio-keys.2 failed with error -22

Ok, I am able to reproduce your issue on a mx53qsb as well.

I haven't seen the issue previously because I was registering only one
key on my mx51-babbage. The failure happens on the subsequent key
registrations.

I fixed it with the attached patch, which just sent it to the linux-input list.

Can you please test it?

Regards,

Fabio Estevam
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-buttonv2.patch
Type: application/octet-stream
Size: 2989 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120820/988ed840/attachment.obj>
