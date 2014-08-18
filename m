From: ttynkkynen@nvidia.com (Tuomas Tynkkynen)
Date: Mon, 18 Aug 2014 13:10:13 +0300
Subject: [PATCH 1/3] of: Add of_match_machine helper
In-Reply-To: <20140817152854.5406BC40ADD@trevor.secretlab.ca>
References: <1407452515-2390-1-git-send-email-ttynkkynen@nvidia.com>	<1407452515-2390-2-git-send-email-ttynkkynen@nvidia.com>
 <20140817152854.5406BC40ADD@trevor.secretlab.ca>
Message-ID: <53F1D105.1070107@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/08/14 18:28, Grant Likely wrote:
> On Fri, 8 Aug 2014 02:01:53 +0300, Tuomas Tynkkynen <ttynkkynen@nvidia.com> wrote:
[...]
>> +EXPORT_SYMBOL(of_match_machine);
> 
> Too wordy...
> 
> 	return of_match_node(matches, of_allnodes);
> 
> :-)
> 
> It could be a static inline, but I don't think it's even worth having a
> helper. The callers could just open code the above.
> 

Do you mean all the drivers should be referring to of_allnodes directly?
I see that it's indeed exported, but to me that sounds like relying too
much on an implementation detail. In fact, Documentation/devicetree/todo.txt
even seems to have a TODO entry for its removal ("Remove of_allnodes list
and iterate using list of child nodes alone").

-- 
nvpublic
