From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Tue, 3 Mar 2015 20:48:54 +0530
Subject: [PATCH 3/3] mailbox: Add support for ST's Mailbox IP
In-Reply-To: <3926609.Ff6LCkuuMX@wuerfel>
References: <1425379283-1567-1-git-send-email-lee.jones@linaro.org>
 <1425379283-1567-4-git-send-email-lee.jones@linaro.org>
 <3926609.Ff6LCkuuMX@wuerfel>
Message-ID: <CAJe_ZhdjPa3C_TUDAPA3fS3K83FGB-GaAjVBjtsow2mp5h8NRw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 March 2015 at 17:04, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 03 March 2015 10:41:23 Lee Jones wrote:
>> +
>> +/*
>> + * struct sti_mbox_msg - sti mailbox message description
>> + * @dsize:             data payload size
>> + * @pdata:             message data payload
>> + */
>> +struct sti_mbox_msg {
>> +       u32             dsize;
>> +       u8              *pdata;
>> +};
>
> As mentioned in another thread, we may just want to add a 'size'
> argument to the message send function, and a default helper for
> messages with size of 32 bits.
>
Case-a) 'size' is a member of the payload structure itself
    The extra 'size' argument would only be used for sanity check.
    This driver seems so. Lee, can you not do without 'dsize'?

Case-b) 'size' is not a member of payload structure:
     b1)  payload is fixed length, that is 'size' := sizeof(struct my_payload)
            Here the size argument is redundant.

     b2)  payload length varies
            This case is highly unlikely because there would be no way
for remote to know how many bytes to read as the payload. Not to mean
we can't do without the 'size' argument.

Your opinion has huge weight, but I would like to be enlightened
before agreeing.

> I don't think it's good to fragment this further by adding
> an indirect message interface in a particular driver.
>
For example, I am reading this again and again without getting it.

Thanks
Jassi
