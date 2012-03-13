From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Tue, 13 Mar 2012 21:36:56 +0100
Subject: [INFO] : Hibernation and Resume between 2 similar devices
In-Reply-To: <28119509.96581331614425960.JavaMail.weblogic@epml27>
References: <28119509.96581331614425960.JavaMail.weblogic@epml27>
Message-ID: <201203132136.56353.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, March 13, 2012, PINTU KUMAR wrote:
> Dear All,
> 
> I am just curious to know if it is possible to "Hibernate in one device" and "Resume the hibernated image from another similar device".

Not out of the box (you'd need to hack the kernel for that to work I think,
at least on x86) and the devices would need to be _exactly_ identical.
Moreover, if there is read-write mass storage in them, the filesystems on
both would have to be exactly identical as well (including metadata and data
layout etc.).

> Suppose, I have 2 exactly similar device (Laptop or mobile phone) with me.
> At one time I will be working on only one device at a time.
> Suppose I started my work on "Device 1"  with few opened application and later I wanted to switch to "Device 2" which is exactly similar to Device 1.
> I thought to hibernate (suspend to disk) the Device 1 and store the hibernated image as a swap file and later transfer to sd card.
> Then take of the sd card from Device 1 and put it into Device 2.
> Copy the swap file from sd card to Device 2 in some swap partition.
> Then reboot the Device 2 to Resume from this swap file.
> I will get back my Device 1 content in Device 2.
> 
> Hope this is possible ?

It may be possible to make it kind of work, but I wouldn't recommend it to
anyone.

Thanks,
Rafael
