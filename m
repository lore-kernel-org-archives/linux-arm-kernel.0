From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 18 Oct 2016 12:25:42 +0200
Subject: [PATCH] mfd: axp20x-i2c: Add i2c-ids to fix module auto-loading
In-Reply-To: <CAGb2v67iQikSHcwS15VmSC6fNMVG9Zya9fz6C6b5+wW43rPZfw@mail.gmail.com>
References: <20161005155112.13774-1-hdegoede@redhat.com>
 <20161005155112.13774-2-hdegoede@redhat.com>
 <CAGb2v67iQikSHcwS15VmSC6fNMVG9Zya9fz6C6b5+wW43rPZfw@mail.gmail.com>
Message-ID: <bbd16837-a260-b574-1b1a-1bede038e3de@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 18-10-16 07:25, Chen-Yu Tsai wrote:
> On Wed, Oct 5, 2016 at 11:51 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>> The i2c subsys does not load modules by compatible, only by
>> i2c-id, with e.g. a modalias of: "i2c:axp209".
>>
>> Populate the axp20x_i2c_id[] table with supported ids, so that
>> module auto-loading will work.
>>
>> Reported-by: Dennis Gilmore <dennis@ausil.us>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>
> Acked-by: Chen-Yu Tsai <wens@csie.org>
>
> Even though axp20x-i2c seems to be the only "DT only" i2c client,
> would it make sense to add DT-based module autoloading to the i2c
> core?

If it is not too invasive, then yes that would be a sensible addition IMHO.

Regards,

Hans
