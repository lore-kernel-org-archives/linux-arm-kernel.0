From: robh+dt@kernel.org (Rob Herring)
Date: Thu, 28 Jul 2016 14:00:21 -0500
Subject: [PATCH 2/2] dt-bindings: add simple-panel-dsi and simple-panel
In-Reply-To: <20160726090226.GB2433@ulmo.ba.sec>
References: <1468984730-23186-1-git-send-email-mark.yao@rock-chips.com>
 <1468984730-23186-2-git-send-email-mark.yao@rock-chips.com>
 <20160725152125.GS21170@ulmo.ba.sec> <5796C47C.5040208@rock-chips.com>
 <20160726090226.GB2433@ulmo.ba.sec>
Message-ID: <CAL_JsqL8D3OK_JQcY+dLTcqcvmgB2Vuc0Tknf1zsR=8Pa3F4jw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 26, 2016 at 4:02 AM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> On Tue, Jul 26, 2016 at 10:01:32AM +0800, Mark yao wrote:
>> On 2016?07?25? 23:21, Thierry Reding wrote:
>>
>>     On Wed, Jul 20, 2016 at 11:18:50AM +0800, Mark Yao wrote:
>>
>>         Allow user add display timing on device tree with simple-panel-dsi
>>         or simple-panel.
>>
>>         Cc: Thierry Reding <thierry.reding@gmail.com>
>>         Cc: Rob Herring <robh+dt@kernel.org>
>>         Cc: Mark Rutland <mark.rutland@arm.com>
>>
>>         Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
>>         ---
>>          .../bindings/display/panel/simple-panel.txt        | 48 ++++++++++++++++++++++
>>          1 file changed, 48 insertions(+)
>>
>>     Sorry, not going to happen. Read this for an explanation of why not:
>>
>>             https://sietch-tagr.blogspot.de/2016/04/display-panels-are-not-special.html
>>
>>     Thierry
>>
>>
>> Hi Thierry
>>
>> The blog actually not persuade me why can't use display timing on
>> device tree.
>
> Okay, perhaps read it again, it addresses most of your points below.
>
>> 1, Binding panel as a simple string on device tree seems simple on device tree,
>> but it's complex on kernel code, and kernel code would became bigger and
>> bigger.
>
> I don't think the video timings in the simple-panel driver are very
> complex. They also don't use very much space. And if you're really
> concerned about space you can always use conditional compilation and
> Kconfig symbols to remove timings for panels that you don't use.
>
> Also, panels are characterized by much more than just video timings.
> There were attempts, way back, to fully describe panels in device tree
> and that failed. What you propose here is a partial solution to a much
> more complex problem.
>
> This is all explained in the blog post.

While I agree with everything Thierry has said in this thread, there
is an argument to be made for timing information in DT.

Maybe most vendors have now learned that flexible clock frequencies
are needed to generate the correct timings, but I have worked on parts
without fine resolution (i.e. a dedicated pll). Even HiKey with HDMI
suffers from this. In that case you can be tuning the timings
(increasing the h and/or v blanks) to get the desired refresh rates.
So in that case, the panel compatible would not determine the display
timings and you could have the same panel with different timings on
different boards. That's maybe rare enough that putting timing info in
DT still wouldn't make sense.

But that is not the problem here, and everything else about this is wrong.

Rob
