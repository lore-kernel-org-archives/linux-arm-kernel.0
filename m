From: sjg@chromium.org (Simon Glass)
Date: Sat, 7 Jan 2012 17:05:31 -0800
Subject: [PATCH v4] Input: keyboard - add device tree bindings for simple
 key matrixes
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF17761F11FF@HQMAIL01.nvidia.com>
References: <1325484557-27695-1-git-send-email-olof@lixom.net>
 <1325626648-9425-1-git-send-email-olof@lixom.net>
 <74CDBE0F657A3D45AFBB94109FB122FF17761F11FF@HQMAIL01.nvidia.com>
Message-ID: <CAPnjgZ3G7yFOrngJP=KtJNcgAWtZg3xn22tRMMi+pUnZ2rJpBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On Tue, Jan 3, 2012 at 2:37 PM, Stephen Warren <swarren@nvidia.com> wrote:
> Olof Johansson wrote at Tuesday, January 03, 2012 2:37 PM:
>> This adds a simple device tree binding for simple key matrix data and
>> a helper to fill in the platform data.
>>
>> The implementation is in a shared file outside if drivers/input/keyboard
>> since some drivers in drivers/input/misc might be making use of it
>> as well.
>>
>> Changes since v3:
>> ?* Dropped compatible field in matrix-keymap.txt
>> ?* Dropped linux,fn-key
>> ?* Dropped linux,fn-keymap optional property but included guideline on
>> ? ?naming convention
>> ?* Now passing property name in to the helper function (or will assume
>> ? ?"linux,keymap" if passed NULL)
>
>> diff --git a/drivers/input/of_keymap.c b/drivers/input/of_keymap.c
>
>> +struct matrix_keymap_data *
>> +matrix_keyboard_of_fill_keymap(struct device_node *np, char *propname)
>> +{
> ...
>> + ? ? kd = kmalloc(sizeof(*kd), GFP_KERNEL);
>> + ? ? if (!kd)
>> + ? ? ? ? ? ? return NULL;
>
> Should that use kzalloc in case struct matrix_keymap_data grows some
> new fields that people will assume are set to zero since the struct
> would usually be in .data? Still, people should probably grep the code
> when making such changes...
>
> Otherwise,
>
> Acked-by: Stephen Warren <swarren@nvidia.com>

Do you have a Tegra .dts binding for the Seaboard keyboard that I can
test with please?

Regards,
Simon

>
> --
> nvpublic
>
