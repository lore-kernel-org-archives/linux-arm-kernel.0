From: zonque@gmail.com (Daniel Mack)
Date: Tue, 31 May 2011 10:56:44 +0200
Subject: Freescale i.mx25 SDIO/Libertas issue
In-Reply-To: <4DE4110D.2090808@bluewatersys.com>
References: <4DE2F84D.8080907@bluewatersys.com>
	<BANLkTi=j3UXV6FMS6vkA+Vrpt3JjsNwMiA@mail.gmail.com>
	<4DE4110D.2090808@bluewatersys.com>
Message-ID: <BANLkTinfnDQcgKvdJv+8PBS9V1PMxQNeoA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andre,

please never reply to people personally when you started a discussion
in the public. Always use the "reply to all" function, so others can
chime in.

On Mon, May 30, 2011 at 11:50 PM, Andre Renaud <andre@bluewatersys.com> wrote:
>> I assume this error happens after the driver uploaded the helper
>> firmware and switched to multi-block transfers?
>>
>> Which kernel version are you working on? I'm asking because I fixed a
>> similar bug some months ago which I happend to see an a MX31 CPU with
>> a 8686 attach to the SDIO bus. The MX3 MMC controller has bug severe
>> bug in its CRC calculation code which causes multi-block transfers on
>> a 4-bit bus to fail, and hence the only solution was to switch to a
>> 1-bit bus. But I don't known whether this also affects MX25 cores.
>>
>> Anyway - this workaround was merged more than a year ago. See if you
>> have commit 1eb46d ("libertas/sdio: 8686: set ECSI bit for 1-bit
>> transfers") in your tree.
>
> Hi Daniel,
> Can you tell me how you force the MX3 into 1-bit mode? I definitely have
> the patch you're referring to - I'm using the head of the mainline git
> tree, and I've verified it is there.

Ok, as Fabian pointed out, the SDHC controller on MX25 SoCs is
completely different, so what I told you can't be the reason, and as
I've never worked with these sort of devices, I can't help much. All I
can recommend is that you trace the driver code with printk()s to see
where it's bailing out.


Daniel
