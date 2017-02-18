From: adanhawthorn@gmail.com (Adan Hawthorn)
Date: Fri, 17 Feb 2017 19:41:14 -0500
Subject: [PATCH 4/5] staging: bcm2835-audio: bcm2835.h: fix volatile
 coding style issue
In-Reply-To: <1487372656.2198.7.camel@perches.com>
References: <1487362603-15967-1-git-send-email-adanhawthorn@gmail.com>
 <1487362603-15967-4-git-send-email-adanhawthorn@gmail.com>
 <1487372656.2198.7.camel@perches.com>
Message-ID: <CADRb1Hah-Xj8hnzR5mJH5-iNoxqiR34rzQ8V2=tkF5MfE2P3sw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thank you, Joe.

Please remove this patch at this time; it was sent in error.

On Fri, Feb 17, 2017 at 6:04 PM, Joe Perches <joe@perches.com> wrote:
> On Fri, 2017-02-17 at 15:16 -0500, Nathan Howard wrote:
>> Fix checkpatch.pl warning of the form "WARNING: Use of volatile is
>> usually wrong: see Documentation/process/volatile-considered-harmful.rst."
>
> Why are you sure the volatile use is not necessary?
>
>> Signed-off-by: Nathan Howard <adanhawthorn@gmail.com>
>> ---
>>  drivers/staging/bcm2835-audio/bcm2835.h | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/staging/bcm2835-audio/bcm2835.h b/drivers/staging/bcm2835-audio/bcm2835.h
>> index 2f9d1c9..08f7ad6 100644
>> --- a/drivers/staging/bcm2835-audio/bcm2835.h
>> +++ b/drivers/staging/bcm2835-audio/bcm2835.h
>> @@ -125,8 +125,8 @@ struct bcm2835_alsa_stream {
>>       struct semaphore buffers_update_sem;
>>       struct semaphore control_sem;
>>       spinlock_t lock;
>> -     volatile unsigned int control;
>> -     volatile unsigned int status;
>> +     unsigned int control;
>> +     unsigned int status;
>>
>>       int open;
>>       int running;
