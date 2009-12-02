From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 2 Dec 2009 23:02:55 +0800
Subject: [PATCH] mmc: pxamci: call mmc_remove_host() before freeing
	resources
In-Reply-To: <20091202110326.GZ14091@buzzloop.caiaq.de>
References: <1259687838-31722-1-git-send-email-daniel@caiaq.de>
	<f17812d70912011650h48a6c391s426ffc8b4b653fc8@mail.gmail.com>
	<20091202110326.GZ14091@buzzloop.caiaq.de>
Message-ID: <f17812d70912020702n318089f0rd2e129b0e45458b2@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 2, 2009 at 7:03 PM, Daniel Mack <daniel@caiaq.de> wrote:
> On Wed, Dec 02, 2009 at 08:50:44AM +0800, Eric Miao wrote:
>> On Wed, Dec 2, 2009 at 1:17 AM, Daniel Mack <daniel@caiaq.de> wrote:
>> > mmc_remove_host() will cause the mmc core to switch off the bus power by
>> > eventually calling pxamci_set_ios(). This function uses the regulator or
>> > the GPIO which have been freed already.
>> >
>> > This causes the following Oops on module unload.
>> >
>
> [...]
>
>> >
>> > Signed-off-by: Daniel Mack <daniel@caiaq.de>
>> > Reported-by: Sven Neumann <s.neumann@raumfeld.com>
>> > Cc: Pierre Ossman <pierre@ossman.eu>
>> > Cc: Eric Miao <eric.y.miao@gmail.com>
>> > Cc: linux-mmc at vger.kernel.org
>> > Cc: linux-arm-kernel at lists.infradead.org
>> > Cc: stable at kernel.org
>> > ---
>> > ?drivers/mmc/host/pxamci.c | ? ?4 ++--
>>
>> Looks like a correct fix to me.
>>
>> Acked-by: Eric Miao <eric.y.miao@gmail.com>
>
> Would be good to still get this into .32 - who will take care of picking
> this?
>

I'll send a pull request, and see if Russell will be happy to send
another one in such a short time :)
