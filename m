From: okaya@codeaurora.org (Sinan Kaya)
Date: Thu, 7 Dec 2017 15:17:52 -0500
Subject: [PATCH V6 3/7] device property: Introduce a common API to fetch
 device match data
In-Reply-To: <20171207124044.utyrn2mzzyml42b2@valkosipuli.retiisi.org.uk>
References: <1512493493-6464-1-git-send-email-okaya@codeaurora.org>
 <1512493493-6464-4-git-send-email-okaya@codeaurora.org>
 <20171207124044.utyrn2mzzyml42b2@valkosipuli.retiisi.org.uk>
Message-ID: <c2b38889-888a-3518-bf59-c2377f64a8ce@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/7/2017 7:40 AM, Sakari Ailus wrote:
> On Tue, Dec 05, 2017 at 12:04:48PM -0500, Sinan Kaya wrote:
>> @@ -101,6 +103,8 @@ struct fwnode_operations {
>>  	(*graph_get_port_parent)(struct fwnode_handle *fwnode);
>>  	int (*graph_parse_endpoint)(const struct fwnode_handle *fwnode,
>>  				    struct fwnode_endpoint *endpoint);
>> +	void *(*get_match_data)(const struct fwnode_handle *fwnode,
>> +				struct device *dev);
> 
> You can make dev const, too.
> 

done, I couldn't change device_get_match_data() parameter const due to
dev_fwnode() function.

                 from /local/mnt/workspace/projects/caf/kernel/drivers/base/property.c:13:

/local/mnt/workspace/projects/caf/kernel/drivers/base/property.c:1341:39: warning: passing argument 1 of 'dev_fwnode' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
  return fwnode_call_ptr_op(dev_fwnode(dev), device_get_match_data,



-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
