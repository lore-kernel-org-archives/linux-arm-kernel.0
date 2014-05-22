From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 23 May 2014 01:02:32 +0200
Subject: [PATCH v3 1/7] pinctrl: berlin: add the core pinctrl driver for
 Marvell Berlin SoCs
In-Reply-To: <CACRpkdbbyfPqFP=-+gO8TmOXSgovjkR_e=N57Xmj-N8jptOzVQ@mail.gmail.com>
References: <1399267649-20218-1-git-send-email-antoine.tenart@free-electrons.com>
 <1399267649-20218-2-git-send-email-antoine.tenart@free-electrons.com>
 <5377351A.6000609@gmail.com>
 <CACRpkdbbyfPqFP=-+gO8TmOXSgovjkR_e=N57Xmj-N8jptOzVQ@mail.gmail.com>
Message-ID: <537E8208.6080308@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/22/2014 11:59 PM, Linus Walleij wrote:
> On Sat, May 17, 2014 at 12:08 PM, Sebastian Hesselbarth
> <sebastian.hesselbarth@gmail.com> wrote:
> 
>> thinking of your request to make "function"/"groups" standard
>> properties, I guess you also had some corresponding helpers in
>> mind.
> 
> Yeah :-)
> 
>> Looking at the map and free functions here, I can see no Berlin
>> specific code at all. One option would be to make those functions
>> a standard callback for .dt_node_to_map and .dt_free_map, i.e.
>> pinctrl_utils_function_group_dt_node_to_map.
>>
>> IMHO, the more flexible option would be to rather have
>>
>> of_pinctrl_utils_read_function(node, &function_name, &ngroups)
>> and
>> of_pinctrl_for_each_function_group(node, group_name)
>> swallowing the property names and reuse it like below.
>>
>> The simple option would be to just remove the marvell, prefix
>> now and have a closer look at other pinctrl drivers to see what
>> will be required, of course.
>>
>> Do you have any preference?
> 
> I would prefer a two-stage rocket, one removing the Marvell prefix
> and another bringing the helpers into pinctrl-utils.

You already the first stage some mails further down in your inbox.

> Do I hear a patch coming? :-)

Yes, but given the late time in v3.15 now and lack of time, I postpone
it to somewhere in v3.16.

Sebastian
