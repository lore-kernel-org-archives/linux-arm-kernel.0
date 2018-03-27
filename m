From: peda@axentia.se (Peter Rosin)
Date: Tue, 27 Mar 2018 15:04:42 +0200
Subject: [PATCH v2 2/5] drm: bridge: add API to query the expected input
 formats of bridges
In-Reply-To: <20180327094743.GL27746@w540>
References: <20180326212447.7380-1-peda@axentia.se>
 <20180326212447.7380-3-peda@axentia.se> <20180327094743.GL27746@w540>
Message-ID: <f35fb82a-d098-475c-4daf-cc2800a70c91@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-03-27 11:47, jacopo mondi wrote:
>> + * RETURNS:
>> + * The number of bus input formats the bridge accepts. Zero means that
>> + * the chain of bridges are not converting the bus format and that the
>> + * format of the drm_connector should be used.
> 
> How do we get to the connector format from a bridge that has maybe
> other components in between in the pipeline?

Forgot to write something here in my previous reply, sorry...

The chain of bridges do not end with the connector in the in-kernel
representation, IIUC. So, I think it is up to the caller to find the
format desired by the connector. See patch [5/5] for an example.

Maybe the connector should be passed in as an argument?

Cheers,
Peter
