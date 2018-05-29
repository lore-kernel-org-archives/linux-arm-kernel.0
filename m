From: robh@kernel.org (Rob Herring)
Date: Tue, 29 May 2018 09:46:46 -0500
Subject: [PATCH v2 1/8] driver core: make deferring probe after init
 optional
In-Reply-To: <1765be22-4bd7-c870-926c-2956e46df1d9@gmail.com>
References: <20180524175024.19874-1-robh@kernel.org>
 <20180524175024.19874-2-robh@kernel.org>
 <20180524181834.GF4828@sirena.org.uk>
 <1765be22-4bd7-c870-926c-2956e46df1d9@gmail.com>
Message-ID: <CAL_JsqKWuOKvyYDVPS_tq8VJ25ZazZvSXBxyu5j4LqDxycyLPg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2018 at 12:12 AM, Frank Rowand <frowand.list@gmail.com> wrote:
> On 05/24/18 11:18, Mark Brown wrote:
>> On Thu, May 24, 2018 at 12:50:17PM -0500, Rob Herring wrote:
>>
>>> Subsystems or drivers may opt-in to this behavior by calling
>>> driver_deferred_probe_check_init_done() instead of just returning
>>> -EPROBE_DEFER. They may use additional information from DT or kernel's
>>> config to decide whether to continue to defer probe or not.
>>
>> Should userspace have some involvement in this decision?  It knows if
>> it's got any intention of loading modules for example.  Kernel config
>> checks might be good enough, though it's going to be a pain to work out
>> if the relevant driver is built as a module for example.
>>
>
> A parallel issue is that loading an overlay could provide the resource
> that will allow the deferred probe to complete.  (That is, once we
> finish implementing the run time overlays feature.)

I'd like to see an actual example where that could happen. I agree you
could craft it, but would it really be a valid partitioning? For
example, SoC pinctrl, iommu, or power domains defined in an overlay
would not be something valid to apply during kernel boot or after boot
(though putting those into overlays is exactly what Alex wants to do).

Rob
