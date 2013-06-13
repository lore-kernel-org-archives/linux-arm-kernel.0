From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 13 Jun 2013 17:13:43 +0400
Subject: [PATCH 6/6] mtd: ofpart: add compatible check for child nodes
In-Reply-To: <51B93FA2.7040206@atmel.com>
References: <1370860014-1770-1-git-send-email-josh.wu@atmel.com>
 <1370860014-1770-7-git-send-email-josh.wu@atmel.com>
 <51B5C80D.2030303@cogentembedded.com> <51B93FA2.7040206@atmel.com>
Message-ID: <51B9C587.4020307@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 13-06-2013 7:42, Josh Wu wrote:

>>> If the child node has compatible property then it is a driver not
>>> partition.

>>> Signed-off-by: Josh Wu <josh.wu@atmel.com>
>>> ---
>>>   drivers/mtd/ofpart.c |   14 +++++++++++++-
>>>   1 file changed, 13 insertions(+), 1 deletion(-)


>>> diff --git a/drivers/mtd/ofpart.c b/drivers/mtd/ofpart.c
>>> index 553d6d6..61ce1f8 100644
>>> --- a/drivers/mtd/ofpart.c
>>> +++ b/drivers/mtd/ofpart.c
>> [...]
>>> @@ -40,8 +44,13 @@ static int parse_ofpart_partitions(struct mtd_info
>>> *master,
>>>       /* First count the subnodes */
>>>       pp = NULL;
>>>       nr_parts = 0;
>>> -    while ((pp = of_get_next_child(node, pp)))
>>> +    while ((pp = of_get_next_child(node, pp))) {

>>    Assignment in *while*? Is scripts/checkpatch.pl happy about that?

> yes, checkpatch.pl has no complain  ;-)

    It seems checkpatch.pl only complains about *if*. Not very consistent...

WBR, Sergei
