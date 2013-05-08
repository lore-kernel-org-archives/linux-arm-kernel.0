From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 9 May 2013 00:39:44 +0800
Subject: [RFC 1/8] serial:st-asc: Add ST ASC driver.
In-Reply-To: <201305081831.48566.arnd@arndb.de>
References: <1368022187-1633-1-git-send-email-srinivas.kandagatla@st.com>
 <B5A00B86-5332-427E-A82A-5B71EC0979A8@jcrosoft.com>
 <20130508161527.GA28080@kroah.com> <201305081831.48566.arnd@arndb.de>
Message-ID: <0940EFC0-EB16-4C13-A3DE-4A8C4F5C6F4D@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On May 9, 2013, at 12:31 AM, Arnd Bergmann <arnd@arndb.de> wrote:

> On Wednesday 08 May 2013, Greg KH wrote:
>>> just mention there is not hardware reason to not use the generic ttySx
>>> in place of ttyAS as we have only one IP that handle serial on this
>>> family of SoC
>>> 
>>> personally I'll switch to ttySx
>> 
>> Great, then you can use the same major/minor range as well, so there's
>> no more objection from me about this :)
> 
> Does that work these days when you have kernel with multiple built-in
> uart drivers?

not for very long time and no this family
> 
> I think it would be good if all uarts were using the same name space
> and major/minor numbers, but I think the mess we currently have is
> the result of the tty_register_driver() interface reserving the
> device number range at driver load time, independent of the presence
> of devices.  I would assume that normal distro kernels always ship
> with an 8250 driver built-in to allow using that as the console,
> and if I read the code correctly, that currently prevents another
> uart driver from registering the same major/minor numbers.

so we need to fix this
> 
> 	Arnd
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
