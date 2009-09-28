From: jernej.turnsek@gmail.com (Jernej Turnsek)
Date: Mon, 28 Sep 2009 11:41:39 +0200
Subject: Problem with mxc_nand driver
In-Reply-To: <4AC07FF9.2040002@eukrea.com>
References: <a57e67db0909272341k59d4cda6pde85ff7425a75c8f@mail.gmail.com>
	<4AC0682D.6000907@eukrea.com>
	<a57e67db0909280156x686f0d26u397dc6397fd0b3a@mail.gmail.com>
	<4AC07FF9.2040002@eukrea.com>
Message-ID: <a57e67db0909280241w61f8d8bbm88ff5d749cc946c2@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

after writing root fs image into nand partition, running the image and
then checking the first empty block I've got following OOB data which
is suspicious to me:

OOB:
	ff ff 85 19 03 20 ff ff
	ff 65 02 08 00 00 00 ff
	ff ff ff ff ff ff ff ff
	ff ff 03 ff ff ff ff ff
	ff ff ff ff ff ff ff ff
	ff ff 03 ff ff ff ff ff
	ff ff ff ff ff ff ff ff
	ff ff 03 ff ff ff ff ff

One can see that bytes on offset 2 to 5 are not empty and when using
the smallpage_memorybased badblock_pattern byte 6 is not FF like it
should be.

Anyone knows what is going on here?

PS: for the not empty pages all first 6 bytes are FF.

BR,
Jernej

On Mon, Sep 28, 2009 at 11:20 AM, Eric B?nard <eric@eukrea.com> wrote:
> Hi,
>
> Jernej Turnsek a ?crit :
>>
>> are you using HW ECC on your chip? I suspect that HW ECC is writting
>> something into space provided for the clean markers. I will
>> investigate to.
>>
> yes, I'm using HW ECC.
> static struct mxc_nand_platform_data eukrea_cpuimx27_nand_board_info = {
> ? ? ? ?.width = 1,
> ? ? ? ?.hw_ecc = 1,
> };
>
> In fact, maybe the change to the NAND driver should test hw_ecc as it
> shouldn't be necessary for software ecc.
>
> Eric
>
