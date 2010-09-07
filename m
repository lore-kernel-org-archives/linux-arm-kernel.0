From: m.nazarewicz@samsung.com (=?utf-8?B?TWljaGHFgiBOYXphcmV3aWN6?=)
Date: Tue, 07 Sep 2010 08:55:12 +0200
Subject: [RFCv5 3/9] mm: cma: Added SysFS support
In-Reply-To: <20100907060818.GA2609@kroah.com>
References: <cover.1283749231.git.mina86@mina86.com>
	<9771a9c07874a642bb587f4c0ebf886d720332b6.1283749231.git.mina86@mina86.com>
	<20100906210747.GA5863@kroah.com> <op.vindmsj07p4s8u@localhost>
	<20100907060818.GA2609@kroah.com>
Message-ID: <op.vinhiabu7p4s8u@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Tue, Sep 07, 2010 at 07:31:30AM +0200, Micha?? Nazarewicz wrote:
>> Thanks for reviewing the sysfs part.  Actually, I was never really sure
>> if I shouldn't rather put this code to debugfs and you got me convinced
>> that I should.  Sysfs somehow looked more appealing from kernel's API
>> point of view -- things seem to be more organised in sysfs than in
>> debugfs.  It seems I'll have to port it to debugfs after all

On Tue, 07 Sep 2010 08:08:18 +0200, Greg KH <greg@kroah.com> wrote:
> Yes, debugfs looks like a much better place for this.

I'll fix that in v6 then.

>>>> +static ssize_t cma_sysfs_region_name_show(struct cma_region *reg, char *page)
>>>> +{
>>>> +	return reg->name ? snprintf(page, PAGE_SIZE, "%s\n", reg->name) : 0;
>>>> +}

>>> Is a name field ever really going to be bigger than a page?

>> For numeric values you are right that snprintf() is a bit paranoid,
>> still I see no good reason why not to use it.

> Same goes for no good reason to use it :)

I somehow prefer to always use "safe" versions of the string manipulation
functions -- it's better to use it everywhere then to forget it in one
place.  Call to sprintf() is translated to vsnprintf() anyway so there's
no performance gain.

-- 
Best regards,                                        _     _
| Humble Liege of Serenely Enlightened Majesty of  o' \,=./ `o
| Computer Science,  Micha? "mina86" Nazarewicz       (o o)
+----[mina86*mina86.com]---[mina86*jabber.org]----ooO--(_)--Ooo--
