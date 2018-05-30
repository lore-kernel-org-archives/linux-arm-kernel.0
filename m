From: okaya@codeaurora.org (okaya at codeaurora.org)
Date: Wed, 30 May 2018 00:56:52 -0700
Subject: [PATCH] PCI: Add pci=safemode option
In-Reply-To: <20180530074822.GB30177@kroah.com>
References: <1527650389-31575-1-git-send-email-okaya@codeaurora.org>
 <20180530043103.GA19734@kroah.com>
 <6c317ed8-cca3-8862-5f3b-12cf14e4d53b@codeaurora.org>
 <20180530073735.GA28793@infradead.org>
 <6dfe2db8f974d94c9867f30ec83d9333@codeaurora.org>
 <20180530074822.GB30177@kroah.com>
Message-ID: <577f01ada5e7f08c79a28d41020fb019@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-05-30 00:48, Greg Kroah-Hartman wrote:
> On Wed, May 30, 2018 at 12:44:29AM -0700, okaya at codeaurora.org wrote:
>> On 2018-05-30 00:37, Christoph Hellwig wrote:
>> > On Tue, May 29, 2018 at 09:41:33PM -0700, Sinan Kaya wrote:
>> > > Bjorn and I discussed the need for such a "safe" mode feature when you
>> > > want to bring up PCI for a platform. You want to turn off everything
>> > > as
>> > > a starter and just stick to bare minimum.
>> >
>> > Can we please make it a config option the instead of adding code
>> > to every kernel?  Also maybe the bringup should be in the name
>> > to make this more clear?
>> 
>> One other requirement was to have a runtime option rather than compile 
>> time
>> option.
>> 
>> When someone reported a problem, we wanted to be able to say "use this
>> option and see if system boots" without doing any bisects or 
>> recompilation.
>> 
>> This would be the first step in troubleshooting a system to see if
>> fundamental features are working.
> 
> That makes sense, people can not rebuild their kernels for the most
> part.  Putting it behind a config option would not make sense as it
> would always have to be enabled.
> 

Here is where the discussion took place. Last 5-10  messages should 
help.


https://bugzilla.kernel.org/show_bug.cgi?id=196197


>> I don't mind changing the name Bjorn mentioned safe option. I made it
>> safemode. I am looking at Bjorn for suggestions at this moment.
> 
> "minimal"?  "basic"?  "crippled"?
> "my_hardware_is_so_borked_it_needs_this_option"?  :)
> 
> Naming is hard...
> 
> greg k-h
