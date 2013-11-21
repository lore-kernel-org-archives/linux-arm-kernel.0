From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 21 Nov 2013 11:52:30 -0700
Subject: [PATCHv5 1/9] of: introduce
 of_property_for_earch_phandle_with_args()
In-Reply-To: <20131121.192051.747601347584525020.hdoyu@nvidia.com>
References: <1384853593-32202-1-git-send-email-hdoyu@nvidia.com><20131121151218.befbb483c0cf09cdcd4cd4dd@nvidia.com><20131121155649.48C96C406A3@trevor.secretlab.ca>
 <20131121.192051.747601347584525020.hdoyu@nvidia.com>
Message-ID: <528E566E.1020704@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/21/2013 10:20 AM, Hiroshi Doyu wrote:
> Grant Likely <grant.likely@linaro.org> wrote @ Thu, 21 Nov 2013 16:56:49 +0100:
> 
>> On Thu, 21 Nov 2013 15:12:18 +0200, Hiroshi Doyu <hdoyu@nvidia.com> wrote:
>>> On Thu, 21 Nov 2013 13:43:28 +0100
>>> Grant Likely <grant.likely@linaro.org> wrote:
>>>
>>>> On Tue, 19 Nov 2013 11:33:05 +0200, Hiroshi Doyu <hdoyu@nvidia.com> wrote:
>>>>> The following pattern of code is tempting:
>>>>>
>>>>>   for (i = 0; !of_parse_phandle_with_args(np, list, cells, i, args); i++)
>>>>>
>>>>> Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
>>>>
>>>> That's a very minimal commit message. Can you elaborate please.
>>>
>>> The above can be:
>>>
>>> "
>>>   The following pattern of code is tempting to add a new member for
>>>   of_property_for_each_*() family as an idiom.
>>>   
>>>     for (i = 0;
>>>         !of_parse_phandle_with_args(np, list, cells, i, args); i++)
>>>                   <do something with "args">;
>>> "
>>
>> I really do like commit messages to be full enough that a future reader
>> can figure out why a patch was written. ie:
> 
> Updated as:
> 
>   [PATCHv6+ 01/13] of: introduce of_property_for_earch_phandle_with_args()
>     http://lists.linuxfoundation.org/pipermail/iommu/2013-November/007063.html
> 
> This doesn't depend on anything and this can be merged
> independetly. Thanks for your help.

Well, that patch doesn't depend /on/ anything, but something in the rest
of the series does depend /on it/. As such, this patch can't be merged
completely independently; it has to either:

a) Go into whatever branch the rest of the series goes into.

b) Go into a topic branch in the DT tree, which is then both merged into
the main/regular DT tree /and/ used as a base for the rest of this series.

Dependencies work two ways!

(That is, unless this 1 patch gets merged into 3.14, and the rest of
series doesn't get merged until 3.15. In that case, we can ignore the
dependencies).
