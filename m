From: james.hogan@imgtec.com (James Hogan)
Date: Wed, 22 May 2013 11:13:17 +0100
Subject: [PATCH v4 3/5] clk: add support for clock reparent on set_rate
In-Reply-To: <519B01DF.1080700@codeaurora.org>
References: <1369056507-32521-1-git-send-email-james.hogan@imgtec.com>
 <1369056507-32521-4-git-send-email-james.hogan@imgtec.com>
 <519B01DF.1080700@codeaurora.org>
Message-ID: <519C9A3D.1010902@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/05/13 06:10, Saravana Kannan wrote:
> On 05/20/2013 06:28 AM, James Hogan wrote:
>> diff --git a/include/linux/clk-private.h b/include/linux/clk-private.h
>> index dd7adff..8138c94 100644
>> --- a/include/linux/clk-private.h
>> +++ b/include/linux/clk-private.h
>> @@ -33,8 +33,11 @@ struct clk {
>>       const char        **parent_names;
>>       struct clk        **parents;
>>       u8            num_parents;
>> +    u8            new_parent_index;
> 
> Why do you need this? Given the new_parent, can't the specific clock
> implementation just look it up when set_rate() is called? Wouldn't that
> be the only time you would actually need the index?
>
> If it's just for optimization of some error cases, I think we should
> drop this to keep the code simpler. One less state to keep track of when
> reading, writing or reviewing the clock framework.

clk_change_rate cannot currently return an error condition so I had
assumed it was better to check that the requested parent clock has a
valid parent index prior to starting to change any clock rates or firing
off any notifications.

Cheers
James
