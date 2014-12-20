From: rickard_strandqvist@spectrumdigital.se (Rickard Strandqvist)
Date: Sat, 20 Dec 2014 17:55:41 +0100
Subject: [PATCH] scsi: arm: cumana_1.c: Remove unused function
In-Reply-To: <20141220165045.GA5013@hudson.localdomain>
References: <1419093375-8016-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
 <20141220165045.GA5013@hudson.localdomain>
Message-ID: <CAFo99gb8+vaQ4xuncMOX7ViivyLoxFLFYpPns9PW4BVkstTptw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-12-20 17:50 GMT+01:00 Jeremiah Mahler <jmmahler@gmail.com>:
> On Sat, Dec 20, 2014 at 05:36:15PM +0100, Rickard Strandqvist wrote:
>> Remove the function cumanascsi_setup() that is not used anywhere.
>>
>> This was partially found by using a static code analysis program called cppcheck.
>>
>> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
>> ---
>>  drivers/scsi/arm/cumana_1.c |    4 ----
>>  1 file changed, 4 deletions(-)
>>
>> diff --git a/drivers/scsi/arm/cumana_1.c b/drivers/scsi/arm/cumana_1.c
>> index 8ef810a..7c90d9c 100644
>> --- a/drivers/scsi/arm/cumana_1.c
>> +++ b/drivers/scsi/arm/cumana_1.c
>> @@ -38,10 +38,6 @@
>>
>>  #include "../NCR5380.h"
>>
>> -void cumanascsi_setup(char *str, int *ints)
>> -{
>> -}
>> -
>>  const char *cumanascsi_info(struct Scsi_Host *spnt)
>>  {
>>       return "";
> [...]
>
> You can blame Linus for this one :-)
>
> ~/linux-next$ git blame -L 38,40 drivers/scsi/arm/cumana_1.c
> ^1da177e (Linus Torvalds 2005-04-16 15:20:36 -0700 38) void
> cumanascsi_setup(char *str, int *ints)
> ^1da177e (Linus Torvalds 2005-04-16 15:20:36 -0700 39) {
> ^1da177e (Linus Torvalds 2005-04-16 15:20:36 -0700 40) }
> ~/linux-next$
>
> --
> - Jeremiah Mahler



It just shows, Linus!
What he has contributed lately  ;-)

Kind regards
Rickard Strandqvist
