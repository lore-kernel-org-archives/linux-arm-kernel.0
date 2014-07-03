From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Thu, 03 Jul 2014 10:12:08 +0100
Subject: [PATCH 1/9 v2] coresight: add CoreSight core layer framework
In-Reply-To: <CANLsYkxKZvb4cOeEfwFB8CbK_PKy6daPL63L00Sx=NvtDjGbfw@mail.gmail.com>
References: <1403892261-25026-1-git-send-email-mathieu.poirier@linaro.org>	<1403892261-25026-2-git-send-email-mathieu.poirier@linaro.org>	<53B3D2F9.2030009@linaro.org>
 <CANLsYkxKZvb4cOeEfwFB8CbK_PKy6daPL63L00Sx=NvtDjGbfw@mail.gmail.com>
Message-ID: <53B51E68.7090308@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/07/14 20:06, Mathieu Poirier wrote:
>>> +struct dentry *cs_debugfs_parent = NULL;
>>> +
>>> +static int curr_sink = NO_SINK;
>>> +static LIST_HEAD(coresight_orph_conns);
>>> +static LIST_HEAD(coresight_devs);
>>> +static DEFINE_SEMAPHORE(coresight_mutex);
>>
>> Why is coresight_mutex a semaphore?
> 
> Bad naming convention.

Really? I only saw it used like a mutex, in other words I thought it was
incorrectly typed, rather than incorrectly named.


>>> +static void coresight_disable_link(struct coresight_device *csdev)
>>> +{
>>> +     int link_subtype;
>>> +     int refport, inport, outport;
>>> +
>>> +     inport = coresight_find_link_inport(csdev);
>>> +     outport = coresight_find_link_outport(csdev);
>>> +
>>> +     link_subtype = csdev->subtype.link_subtype;
>>> +     if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_MERG)
>>> +             refport = inport;
>>> +     else if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_SPLIT)
>>> +             refport = outport;
>>> +     else
>>> +             refport = 0;
>>
>> I already read these 7 lines once...
> 
> It is really worth spinning off a function to save 5 lines?

Pretty marginal really. If the code here stays as it is I don't care
enough to raise this point a second time.


Daniel.
