From: prylowski@metasoft.pl (Rafal Prylowski)
Date: Fri, 30 Mar 2012 10:32:25 +0200
Subject: [PATCH 3/3] ep93xx: Add IDE support to edb93xx boards
In-Reply-To: <ADE657CA350FB648AAC2C43247A983F00206970255C3@AUSP01VMBX24.collaborationhost.net>
References: <4F7418E7.4060500@metasoft.pl> <4F741B3F.4000507@metasoft.pl>
 <ADE657CA350FB648AAC2C43247A983F00206970255C3@AUSP01VMBX24.collaborationhost.net>
Message-ID: <4F756F99.8090301@metasoft.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2012-03-29 18:32, H Hartley Sweeten wrote:
>> +static int __init edb93xx_has_ide(void)
>> +{
>> +	/*
>> +	 * Although EDB9312 and EDB9315 do have IDE capability, they have
>> +	 * INTRQ line wired as pull-up, which makes using IDE interface
>> +	 * problematic.
>> +	 */
>> +	return machine_is_edb9315a();
> 
> Allow the driver to be loaded on the EDB9312 and EDB9315 but leave the comment.
> If a use of these boards wishes to use the IDE they could remove the pull-up and add
> a pull-down to their board.

Ok. Will do that.
