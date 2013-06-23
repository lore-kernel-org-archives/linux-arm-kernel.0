From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 23 Jun 2013 20:13:16 +0200
Subject: No stable driver/module api?
In-Reply-To: <CABp-a4eHep=hx7HQ=Og0GC0t=CyE8u2sVt7BwyVMJb9zjA2ePw@mail.gmail.com>
References: <CABp-a4eHep=hx7HQ=Og0GC0t=CyE8u2sVt7BwyVMJb9zjA2ePw@mail.gmail.com>
Message-ID: <2105177.8kY1vWxy2t@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 23 June 2013 19:29:52 Per Strandh wrote:
> 
> I have now encountered one problem with this layout.
> When upgrading the kernel, our driver in the root file system isn't
> always compatible/loading.
> 
> When upgrading from 3.0.18 to 3.0.22 it worked out fine.
> When upgrading from 3.0.22 to 3.0.23 the driver isn't loading.
> When trying to load it if fails with the message:
> - "disagrees about version of symbol module_layout"
> 
> We have configured the kernel with the option
>  CONFIG_MODULE_FORCE_LOAD=y
> 
> 
> 
> Isn't the driver/module api stable within the 3.0 track?

The API is generally stable, unless there is a serious bug,
the ABI is not. If the API ever changes, you should get a build
warning when recompiling your module.

The easiest way to deal with those changes is to keep your
own code as a patch to the mainline kernel and build it all
together. That also makes it easier for your to show that
you are shipping the matching source code for all the
binary kernel code.

	Arnd
