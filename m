From: pintu_agarwal@yahoo.com (PINTU KUMAR)
Date: Wed, 14 Mar 2012 03:21:58 -0700 (PDT)
Subject: [INFO] : Hibernation and Resume between 2 similar devices
In-Reply-To: <201203132136.56353.rjw@sisk.pl>
References: <28119509.96581331614425960.JavaMail.weblogic@epml27>
 <201203132136.56353.rjw@sisk.pl>
Message-ID: <1331720518.14716.YahooMailNeo@web162005.mail.bf1.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>________________________________
>From: Rafael J. Wysocki <rjw@sisk.pl>
>To: pintu.k at samsung.com 
>Cc: linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org 
>Sent: Wednesday, 14 March 2012 2:06 AM
>Subject: Re: [INFO] : Hibernation and Resume between 2 similar devices
>
>On Tuesday, March 13, 2012, PINTU KUMAR wrote:
>> Dear All,
>> 
>> I am just curious to know if it is possible to "Hibernate in one device" and "Resume the hibernated image from another similar device".
>
>Not out of the box (you'd need to hack the kernel for that to work I think,
>at least on x86) and the devices would need to be _exactly_ identical.
>Moreover, if there is read-write mass storage in them, the filesystems on
>both would have to be exactly identical as well (including metadata and data
>layout etc.).
?
[Pintu]
I wanted to try this on arm based Linux mobile phone.
I have 2 exactly similar mobile phone.
Here exactly means: 
hardware is same, kernel version is same, platform is same, filesystem is same.
The only difference could be some user space application state.
Hmmm.....the metadata and data layout within file system....this is were the confusion is.
Suppose in "Device 1" during hibernation, I have a file say "file1.txt" opened whose inode number is say "123456".
This opened state of file1.txt will be captured in hibernation image.
Now assume that same "file1.txt" is also present (not opened) in "Device2" but whose inode number is say "567890".
Now if I reboot "Device 2" and try to resume from hibernated image of "Device 1", what would happen to "file1.txt" ??
And similarly other senarios.......
Will resume work, at least partially. Like discard whatever is not relevant to "Device 2" and continue to load others.


>
>> Suppose, I have 2 exactly similar device (Laptop or mobile phone) with me.
>> At one time I will be working on only one device at a time.
>> Suppose I started my work on "Device 1"? with few opened application and later I wanted to switch to "Device 2" which is exactly similar to Device 1.
>> I thought to hibernate (suspend to disk) the Device 1 and store the hibernated image as a swap file and later transfer to sd card.
>> Then take of the sd card from Device 1 and put it into Device 2.
>> Copy the swap file from sd card to Device 2 in some swap partition.
>> Then reboot the Device 2 to Resume from this swap file.
>> I will get back my Device 1 content in Device 2.
>> 
>> Hope this is possible ?
>
>It may be possible to make it kind of work, but I wouldn't recommend it to
>anyone.
?
[Pintu]
if this can be possible we can derive many use cases.
Till now we heard about hibernating and resuming from same device. And also people uses it rarely.
With the Tizen coming up (supporting multiple devices) we can think about it.
Also if "cloud" is integrated with kernel in _future_ we can save all our work from one device in cloud and restore our work from cloud in another device.
I think that make sense.


?
>
>Thanks,
>Rafael
>
>_______________________________________________
>linux-arm-kernel mailing list
>linux-arm-kernel at lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
>
>
