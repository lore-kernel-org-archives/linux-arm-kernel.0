From: rusty@rustcorp.com.au (Rusty Russell)
Date: Mon, 13 May 2013 10:46:07 +0930
Subject: [PATCH V2 2/3] Documentation: virtio: Add emergency write
 (emerg_wr) config register in virtio console.
In-Reply-To: <1367902933.18069.212@driftwood>
References: <1367842791-30285-1-git-send-email-pranavkumar@linaro.org>
 <1367842791-30285-3-git-send-email-pranavkumar@linaro.org>
 <1367902933.18069.212@driftwood>
Message-ID: <87obcf3ciw.fsf@rustcorp.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob Landley <rob@landley.net> writes:
> On 05/06/2013 07:19:50 AM, Pranavkumar Sawargaonkar wrote:
>> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
>> Signed-off-by: Anup Patel <anup.patel@linaro.org>
>> ---
>>  Documentation/virtual/virtio-spec.txt |    8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>> 
>> diff --git a/Documentation/virtual/virtio-spec.txt  
>> b/Documentation/virtual/virtio-spec.txt
>> index 0d6ec85..3ca38f8 100644
>> --- a/Documentation/virtual/virtio-spec.txt
>> +++ b/Documentation/virtual/virtio-spec.txt
>> @@ -1927,11 +1927,16 @@ Ports 2 onwards only if  
>> VIRTIO_CONSOLE_F_MULTIPORT is set
>>      ports; configuration fields nr_ports and max_nr_ports are
>>      valid and control virtqueues will be used.
>> 
>> +  VIRTIO_CONSOLE_F_EMERG_WRITE(2) Device has support for emergency
>> +  write. Configuration filed emerg_wr is valid.
>
> Emergency?
>
> Really?
>
> Out of morbid curiosity, what would constitute an _emergency_ in a  
> virtual machine logging context?

Usually, your console device is broken.  Or you can't set it up because
you can't allocate memory.  Or you oops before it is configured.

Terminology is a tricky thing, but the nuance here is that you don't
want to use this as your main console.  It may not do anything.  It may
drop characters.  It's definitely slow.

Cheers,
Rusty.
