From: anish198519851985@gmail.com (anish singh)
Date: Fri, 24 May 2013 12:52:40 +0530
Subject: [I2C] informations + advice about messages handling
In-Reply-To: <CA78C307B8F06747967D122FC656B153986448@SERVEUR0.nvp.local>
References: <CA78C307B8F06747967D122FC656B153986448@SERVEUR0.nvp.local>
Message-ID: <CAK7N6vpg6QUAKODKO2Msr4+GTASLDpA2cG1teQV3yiwt7D4SSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 24, 2013 at 12:41 PM, Mylene Josserand
<Mylene.Josserand@navocap.com> wrote:
> Hi all,
>
>
> I am learning how i2c is working and I read that, to write in an i2c
> register, I need to use the function "i2c_smbus_write_byte_data".
Only in case your device is smbus compliant.

> I wanted to know how the message are handled by using this function. If
> I use this function to talk with 2 different i2d devices, how it will
> handle "message collision" ? should I have to add a kind of mutex on the
Message collision and detection is the job of i2c controller and if I am
not wrong you are writing a chip driver.
> access of the i2c bus ?
> Is it possible that the message destined for one device is sent to
> another one ? Or a "mix" of messages is impossible ?
It is not possible as the data contains the chip address which is
unique.7/10 bit mode addressing is used for addresses.
>
> I have read that this function "i2c_smbus_write_byte_data" uses
> "i2c_smbus_xfer" which uses "i2c_lock_adapter".
> In this function, there is a mutex so I thought that it will handle it
> but it says "Get exclusive access to an I2C bus segment". What is
> exactly an I2C segment ? Is it the device we are talking about ? Or is
> it the use of the i2c bus ?
Don't know what you are referring here.
>
> I will certainly have to create an i2c driver and I would like to know
> if this "collision" handling (if it is handled) is done in old kernel
> (2.6.32) or is it handled only in new kernel versions ?
AFAIK collision handling and detection was not supported till now
in linux kernel until recently but I think this patch is doing that.
I may be wrong but I didn't see collision handling in earlier linux
kernels.
http://thread.gmane.org/gmane.linux.kernel/1410276
>
> If you have any documentation on how the i2c messages are handled in
> case of different devices uses, it will help me a lot ! I will search in
> the kernel documentation but there is many files about i2c.
> And if you know a good i2c driver that I can use as an example to design
> mine, it will be great !
>
>
> Thank you in advance,
>
> --
> Myl?ne JOSSERAND
>
> _______________________________________________
> Kernelnewbies mailing list
> Kernelnewbies at kernelnewbies.org
> http://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies
