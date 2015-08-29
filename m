From: davem@davemloft.net (David Miller)
Date: Fri, 28 Aug 2015 22:10:49 -0700 (PDT)
Subject: [PATCH net-next 7/8] net: thunderx: Support for upto 96 queues
 for a VF
In-Reply-To: <CALW4P+KVjSFA3F+9wHTMiyMHkFjrbedP2LpUu033-o0k32F0nw@mail.gmail.com>
References: <1440774004-27923-1-git-send-email-aleksey.makarov@auriga.com>
 <1440774004-27923-7-git-send-email-aleksey.makarov@auriga.com>
 <CALW4P+KVjSFA3F+9wHTMiyMHkFjrbedP2LpUu033-o0k32F0nw@mail.gmail.com>
Message-ID: <20150828.221049.256686243264204039.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alexey Klimov <klimov.linux@gmail.com>
Date: Sat, 29 Aug 2015 04:45:03 +0300

>> @@ -717,9 +833,24 @@ static void nic_unregister_interrupts(struct nicpf *nic)
>>         nic_disable_msix(nic);
>>  }
>>
>> +static int nic_num_sqs_en(struct nicpf *nic, int vf_en)
>> +{
>> +       int pos = 0, sqs_per_vf = MAX_SQS_PER_VF_SINGLE_NODE;
> 
> Please check if you really need to initialize 'pos' by zero here.

Please do _NOT_ quote hundreds of lines of code only to give feedback
on one particular hunk.

Quote _ONLY_ the exact context required, nothing more.

Everyone has to scroll through all of this unrelated crap you quoted,
and that makes more work for everyone.

Think particularly of _ME_ who has to be aware of what's going on in
every discussion thread for every patch that gets posted to this list.
