From: rubini@gnudd.com (Alessandro Rubini)
Date: Thu, 31 May 2012 20:02:04 +0200
Subject: [PATCH RFC 2/3] i2c-nomadik: turn the platform driver to an
 amba driver
In-Reply-To: <CACRpkdZpjn0RBGY+CqqSW3ip0MSQUJSaqN0GD=a4THnPHNM-jg@mail.gmail.com>
References: <CACRpkdZpjn0RBGY+CqqSW3ip0MSQUJSaqN0GD=a4THnPHNM-jg@mail.gmail.com>
 <cover.1338398567.git.rubini@gnudd.com>
 <349645b61d0b28f6e84f7ae1f2c8c28e12a11d92.1338398567.git.rubini@gnudd.com>
 <CACRpkdZ79=B8N7omxYY4UPotg8gYotfLeBRViYMr8hA-Uhie0w@mail.gmail.com>
 <4FC72DDF.7080209@codethink.co.uk>
Message-ID: <20120531180204.GA28779@mail.gnudd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> But since the device has PrimeCell ID registers, this is really the
> right thing to do anyway, since autodetecting from hardware is
> allways NiceToDo(TM).  Else ST and us shouldn't have put the magic
> numbers (0xB105F00D) in there anyway.

Exactly. The pci-amba.c driver just says "here's an amba thing at
my BAR0 address", and then it is idenfitied automatically. There is
also automatic modalias support in place.

So I'll resubmit in the right way (-M, include/linux/platform_data)
as soon as I have information for ftd fixup.

Thanks
/alessandro
