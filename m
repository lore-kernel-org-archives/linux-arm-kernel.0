From: nicolae.rosia.oss@gmail.com (Nicolae Rosia)
Date: Sun, 20 Nov 2016 14:54:25 +0200
Subject: [PATCH] mfd: twl-core: export twl_get_regmap
In-Reply-To: <20161118185548.GA23246@dell.home>
References: <1478950693-13959-1-git-send-email-Nicolae_Rosia@mentor.com>
 <20161118185548.GA23246@dell.home>
Message-ID: <CAKP5S=3quz8f1H0xnaffJ35L8qSOpSkBEGS8GsNhB5F=v3DoBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 18, 2016 at 8:55 PM, Lee Jones <lee.jones@linaro.org> wrote:
> On Sat, 12 Nov 2016, Nicolae Rosia wrote:
>
>> We want to get rid of global twl_i2c_{write/read}.
>> As a first step, allow clients to get the regmap and write directly
>
> What's stopping you from passing it through device data?
>
Could you elaborate a bit?
The regmaps are stored in struct twl_client [0], stored in struct
twl_private [1], both structs are defined in the source file, not in
header.
I could however just fix the problem by reworking the struct, exposing
it and use mfd_add_device as real mfd drivers do.

[0] http://lxr.free-electrons.com/source/drivers/mfd/twl-core.c#L152
[1] http://lxr.free-electrons.com/source/drivers/mfd/twl-core.c#L163
