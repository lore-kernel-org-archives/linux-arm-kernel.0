From: marcel@holtmann.org (Marcel Holtmann)
Date: Wed, 3 Aug 2016 11:53:06 +0200
Subject: [PATCH] Add file permission mode helpers
In-Reply-To: <20160803082855.GA32280@kroah.com>
References: <CA+55aFw5v23T-zvDZp-MmD_EYxF8WbafwwB59934FV7g21uMGQ@mail.gmail.com>
 <20160803081140.GA7833@gmail.com> <20160803082855.GA32280@kroah.com>
Message-ID: <20EC504F-F679-4244-8C04-00165236D028@holtmann.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

>> An added advantage would be that during review it would stick out like a sore 
>> thumb if anyone used a 'weird' permission variant.
>> 
>> For example, if you saw these lines in a driver patch:
>> 
>> +	__ATTR(l1, 0444, driver_show_l4, NULL);
>> +		__ATTR(l3, 0446, driver_show_l4, NULL);
>> +			__ATTR(l2, 04444, driver_show_l4, NULL);
>> +		__ATTR(l4, 0444, driver_show_l4, NULL);
>> 
>> ... would you notice it at a glance that it contains two security holes?
> 
> I've tried to deal with that in the past with the __ATTR_RW() and
> __ATTR_RO() and __ATTR_WO() macros that more should be using.  I swept
> the tree a few years ago to try to fix up most of them, but I know I
> didn't catch them all, and more files have been added since then.

I said in another response that maybe module_param_rw and module_param_ro will make some sense. Not sure if they are easier to read or not. I mean for each usage, we could look at the tree and see what values are actually used. My bet is that for module_param only a few ones are used. I have the feeling it is 0444 or 0644 and nothing else. Maybe some outlaws with 0400 and 0600 that don't even need to be that secretive.

Regards

Marcel
