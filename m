From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Mon, 10 Sep 2018 09:36:32 +0200
Subject: [PATCH v2 11/16] nvmem: add support for cell info
In-Reply-To: <21ec4e6f-aa39-66cf-af32-d9e8e85f4961@linaro.org>
References: <20180907100750.14564-1-brgl@bgdev.pl>
 <20180907100750.14564-12-brgl@bgdev.pl>
 <21ec4e6f-aa39-66cf-af32-d9e8e85f4961@linaro.org>
Message-ID: <20180910093632.3a9337a9@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Srinivas,

On Mon, 10 Sep 2018 08:32:21 +0100
Srinivas Kandagatla <srinivas.kandagatla@linaro.org> wrote:

> On 07/09/18 11:07, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > 
> > Add new structs and routines allowing users to define nvmem cells from
> > machine code. This global list of entries is parsed when a provider
> > is registered and cells are associated with the relevant nvmem_device
> > struct.
> > 
> > A possible improvement for the future is to allow users to register
> > cell tables after the nvmem provider has been registered by updating
> > the cell list at each call to nvmem_(add|del)_cell_table().
> > 
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---
> >   MAINTAINERS                   |  1 +
> >   drivers/nvmem/core.c          | 97 ++++++++++++++++++++++++++++++++++-  
> 
> I see some of this code is removed in first patch and added back here, I 
> dont really see a value in doing this in a single series of patchset.
> 
> I would recommend "[PATCH v2 01/16] nvmem: remove unused APIs" and this 
> patch to be merged.
> 
> >   include/linux/nvmem-machine.h | 41 +++++++++++++++
> >   3 files changed, 138 insertions(+), 1 deletion(-)
> >   create mode 100644 include/linux/nvmem-machine.h
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 9ad052aeac39..a520924bf0a9 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -10391,6 +10391,7 @@ F:	drivers/nvmem/
> >   F:	Documentation/devicetree/bindings/nvmem/
> >   F:	Documentation/ABI/stable/sysfs-bus-nvmem
> >   F:	include/linux/nvmem-consumer.h
> > +F:	include/linux/nvmem-machine.h
> >   F:	include/linux/nvmem-provider.h
> >   
> >   NXP SGTL5000 DRIVER
> > diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> > index 17307015905a..854baa0559a1 100644
> > --- a/drivers/nvmem/core.c
> > +++ b/drivers/nvmem/core.c  
> ...
> >    *
> > diff --git a/include/linux/nvmem-machine.h b/include/linux/nvmem-machine.h
> > new file mode 100644
> > index 000000000000..1e199dfaacab
> > --- /dev/null
> > +++ b/include/linux/nvmem-machine.h  
> 
> This should go in nvmem-consumer.h, I don't think we should add header 
> files for each usecase. These are nvmem consumers so lets put them in 
> correct header file.

Actually no, it should go in nvmem-provider.h. Consumer should not be
allowed to define cells, only reference existing ones.

Regards,

Boris
