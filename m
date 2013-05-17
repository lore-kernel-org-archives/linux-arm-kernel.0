From: oliver+list@schinagl.nl (Oliver Schinagl)
Date: Fri, 17 May 2013 20:54:45 +0200
Subject: [PATCH 1/2] Initial support for Allwinner's Security ID fuses
In-Reply-To: <4144514.S8gIuIKLrJ@wuerfel>
References: <1368797744-13737-1-git-send-email-oliver+list@schinagl.nl>
 <1368797744-13737-2-git-send-email-oliver+list@schinagl.nl>
 <4144514.S8gIuIKLrJ@wuerfel>
Message-ID: <51967CF5.7060806@schinagl.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/17/13 15:45, Arnd Bergmann wrote:
> On Friday 17 May 2013 15:35:43 Oliver Schinagl wrote:
>> +static struct bin_attribute sid_bin_attr = {
>> +       .attr = {
>> +               .name = "key",
>> +               .mode = S_IRUGO,
>> +       },
>> +       .size = SUNXI_SID_SIZE,
>> +       .read = sid_read,
>> +};
>
> I believe all the other drivers in drivers/misc/eeprom use "eeprom"
> as the name for the attribute, so using "key" here is a bit inconsistent.
>
> Can you change that?
Changed, will wait for more feedback and then use that in the final version.

Should there also be a symlink elsewhere in /sys? Just curious is all.
>
> 	Arnd
>
