From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Mon, 7 May 2012 18:05:17 +0300
Subject: [PATCH v2 3/3] omap: remoteproc: add support for a boot register
In-Reply-To: <CADVn9RFOBdw0_19ErT6qEpy7325TG7wWkDfJtdF-6jq74z3nFw@mail.gmail.com>
References: <1334360392-1494-1-git-send-email-jgutierrez@ti.com>
 <1334360392-1494-4-git-send-email-jgutierrez@ti.com>
 <CAK=Wgbb4bJ22BYh444Xndaody7Q7Eoox3K7zvGCFmf6ZMHAa0w@mail.gmail.com>
 <CADVn9RFOBdw0_19ErT6qEpy7325TG7wWkDfJtdF-6jq74z3nFw@mail.gmail.com>
Message-ID: <CAK=WgbYHxh7tJhzApEWrkjQmkJGMWpnXynTPH5QUDnJ-TnVaYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Juan,

On Mon, May 7, 2012 at 5:38 PM, Gutierrez, Juan <jgutierrez@ti.com> wrote:
>> > @@ -40,6 +41,7 @@ struct omap_rproc_pdata {
>> > ? ? ? ?const struct rproc_ops *ops;
>> > ? ? ? ?int (*device_enable) (struct platform_device *pdev);
>> > ? ? ? ?int (*device_shutdown) (struct platform_device *pdev);
>> > + ? ? ? u32 boot_reg;
>>
>> We might want to use an IORESOURCE_MEM resource instead, since we're
>> dealing with a platform device anyway.
>>
>> The driver can then fetch the address using platform_get_resource.
>
> Ok, Do you mean using resource table to get the boot_reg address, right?

Sorry for the confusion - I meant using a 'struct resource' as the
standard way to pass this kind of information to platform drivers.

For example take a look how omap2_mbox_probe uses
platform_get_resource to retrieve the parameters which it then feeds
to ioremap.

Using this standard approach will probably make life easier when we
migrate to DT, too.

Thanks,
Ohad.
