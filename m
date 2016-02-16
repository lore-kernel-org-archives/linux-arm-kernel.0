From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Tue, 16 Feb 2016 02:21:59 +0100
Subject: [PATCH v6 1/2] ACPI: introduce a function to find the first
 physical device
In-Reply-To: <CAHp75VcdtU6izThE+Z2ODnYoXk-uhweXzUtFwSze_jJHw3+38g@mail.gmail.com>
References: <1453300171-25473-1-git-send-email-aleksey.makarov@linaro.org>
 <1453300171-25473-2-git-send-email-aleksey.makarov@linaro.org>
 <CAHp75VcdtU6izThE+Z2ODnYoXk-uhweXzUtFwSze_jJHw3+38g@mail.gmail.com>
Message-ID: <2019010.CjT5f3j553@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, January 20, 2016 05:12:18 PM Andy Shevchenko wrote:
> On Wed, Jan 20, 2016 at 4:29 PM, Aleksey Makarov
> <aleksey.makarov@linaro.org> wrote:
> > Factor out the code that finds the first physical device
> > of a given ACPI device.  It is used in several places.
> >
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
> 
> Hmm? Sorry, didn't notice one style issue and there is one is matter
> of taste below.
> 
> > --- a/drivers/acpi/acpi_platform.c
> > +++ b/drivers/acpi/acpi_platform.c
> > @@ -43,7 +43,6 @@ static const struct acpi_device_id forbidden_id_list[] = {
> 
> > +       pdevinfo.parent = adev->parent ?
> > +               acpi_get_first_physical_node(adev->parent) : NULL;
> 
> Matter of taste, but I believe if-else looks better here even when
> consumes +2 LOC.

I disagree.

Thanks,
Rafael
