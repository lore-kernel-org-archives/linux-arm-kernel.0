From: sricharan@codeaurora.org (Sricharan R)
Date: Tue, 22 Aug 2017 18:09:01 +0530
Subject: [PATCH 11/18] rpmsg: glink: Use the local intents when receiving
 data
In-Reply-To: <1dc63580-4a6c-750a-7cb6-00906a4ea4c0@codeaurora.org>
References: <1502903951-5403-1-git-send-email-sricharan@codeaurora.org>
 <1502903951-5403-12-git-send-email-sricharan@codeaurora.org>
 <1dc63580-4a6c-750a-7cb6-00906a4ea4c0@codeaurora.org>
Message-ID: <65d6412f-ee00-09b1-59ee-7ff20d65827b@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

<snip..>

>> ? -??? /* Might have an ongoing, fragmented, message to append */
>> -??? if (!channel->buf) {
>> -??????? channel->buf = kmalloc(chunk_size + left_size, GFP_ATOMIC);
>> -??????? if (!channel->buf)
>> -??????????? return -ENOMEM;
>> +??? if (glink->intentless) {
>> +??????? /* Might have an ongoing, fragmented, message to append */
>> +??????? if (!channel->buf) {
>> +??????????? intent = kzalloc(sizeof(*intent), GFP_ATOMIC);
>> +??????????? if (!intent)
>> +??????????????? return -ENOMEM;
>> +
>> +??????????? intent->data = kmalloc(chunk_size + left_size,
>> +?????????????????????????? GFP_ATOMIC);
> 
> Who is supposed to free the intent and intent->data memory ?
 Well, that's done as a part of the rx_done_work.

Regards,
 Sricharan
 
-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

---
This email has been checked for viruses by Avast antivirus software.
https://www.avast.com/antivirus
