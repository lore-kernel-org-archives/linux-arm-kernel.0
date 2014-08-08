From: ttynkkynen@nvidia.com (Tuomas Tynkkynen)
Date: Fri, 8 Aug 2014 16:23:26 +0300
Subject: [PATCH 1/3] of: Add of_match_machine helper
In-Reply-To: <20140808094123.GC5387@ulmo>
References: <1407452515-2390-1-git-send-email-ttynkkynen@nvidia.com>
 <1407452515-2390-2-git-send-email-ttynkkynen@nvidia.com>
 <20140808094123.GC5387@ulmo>
Message-ID: <53E4CF4E.6010500@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/08/14 12:41, Thierry Reding wrote:
> 
>> +const struct of_device_id *of_match_machine(const struct of_device_id *matches)
>> +{
>> +	const struct of_device_id *match;
>> +	struct device_node *root;
>> +
>> +	root = of_find_node_by_path("/");
>> +	if (!root)
>> +		return NULL;
>> +
>> +	match = of_match_node(matches, root);
>> +	of_node_put(root);
>> +	return match;
>> +}
>> +EXPORT_SYMBOL(of_match_machine);
> 
> I wonder if of_find_node_by_path("/") is somewhat overkill here. Perhaps
> simply of_node_get(of_allnodes) would be more appropriate here since the
> function is implemented in the core?

of_machine_is_compatible() uses of_find_node_by_path("/") as well, of_allnodes
seems to be only used when during iterating. So I'd prefer to have them
consistent.

-- 
nvpublic
