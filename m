From: sean.wang@mediatek.com (Sean Wang)
Date: Fri, 22 Sep 2017 11:59:47 +0800
Subject: [PATCH 2/5] nvmem: mtk-efuse: use stack for nvmem_config
 instead of malloc'ing it
In-Reply-To: <CAK7LNARoZnVduzkWqyTYq4iMEAi0A88cpGWrD0Zc=wt=Xa+1QA@mail.gmail.com>
References: <1505134864-11975-1-git-send-email-yamada.masahiro@socionext.com>
 <1505134864-11975-3-git-send-email-yamada.masahiro@socionext.com>
 <1505925159.17049.12.camel@mtkswgap22>
 <CAK7LNARoZnVduzkWqyTYq4iMEAi0A88cpGWrD0Zc=wt=Xa+1QA@mail.gmail.com>
Message-ID: <1506052787.21515.10.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Masahiro

On Thu, 2017-09-21 at 11:09 +0900, Masahiro Yamada wrote:
> Hi Sean,
> 
> 
> 2017-09-21 1:32 GMT+09:00 Sean Wang <sean.wang@mediatek.com>:
> > Hi, Masahiro
> >
> > For maintainability, I felt it's better if we use the same way to
> > register nvmem as that most drivers does under nvmem usually using
> > static structure. Otherwise, they should also be changed to use the
> > one-time data in stack to avoid extra bytes to keep them.
> >
> >         Sean
> 
> 
> Srinivas and I discussed the best practice for allocating nvmem_config.
> https://lkml.org/lkml/2017/9/11/4
> 
> From the discussion, static structure is possible only when
> the system has one instance of the device.
> 

thank you for your detailed explanation

> If you know this is the case for mediatek,
> yes, you can turn it into static,
> but it is not always possible.
> For example, Socionext SoCs have
> two banks of efuse devices.
> 

there should be only one instance of nvmem for mediatek soc, currently


> So, if we want to align the coding style for consistency,
> nvmem in stack is safe and efficient, I think.
> 
> 
> Moving one-time data into stack slightly
> reduces the kernel image size.
> 
> 

agreed on those statements, indeed bigger struct uart_8250_port is still
used on stack for configuring in a lot 8250 driver, so 

Acked-by: Sean Wang <sean.wang@mediatek.com>
