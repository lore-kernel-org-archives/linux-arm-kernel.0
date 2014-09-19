From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Fri, 19 Sep 2014 19:39:54 +0200
Subject: [PATCH v4] mfd: syscon: Decouple syscon interface from platform
 devices
In-Reply-To: <541C47BD.3070601@gmail.com>
References: <1411132009-11173-1-git-send-email-pankaj.dubey@samsung.com>
 <541C47BD.3070601@gmail.com>
Message-ID: <541C6A6A.40006@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19.09.2014 17:11, Tomasz Figa wrote:
>> +
>> +	if (!of_device_is_available(np) ||
> 
> Wouldn't it be enough to simply call of_find_device_by_node(np) and if
> it fails then instead create a dummy device?
> 
>> +			of_node_test_and_set_flag(np, OF_POPULATED)) {

One more thing I forgot to mention, the call to
of_node_test_and_set_flag() is also wrong, because it sets the flag,
marking the device as already populated, while it isn't.

Best regards,
Tomasz
