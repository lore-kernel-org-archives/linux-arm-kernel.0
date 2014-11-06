From: linux@roeck-us.net (Guenter Roeck)
Date: Wed, 05 Nov 2014 21:59:47 -0800
Subject: [PATCHv0 3/3] rtc: rtc-isl12057: add alarm support to Intersil
 ISL12057 RTC driver
In-Reply-To: <20141106055017.GL8509@sirena.org.uk>
References: <cover.1415222752.git.arno@natisbad.org>
 <148403c0ab1d556cbb99d9242c65f714a77843e5.1415222752.git.arno@natisbad.org>
 <20141106055017.GL8509@sirena.org.uk>
Message-ID: <545B0E53.4020003@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/05/2014 09:50 PM, Mark Brown wrote:
> On Wed, Nov 05, 2014 at 10:42:52PM +0100, Arnaud Ebalard wrote:
>
>> +static int _isl12057_rtc_toggle_alarm(struct device *dev, int enable)
>> +{
>> +	struct isl12057_rtc_data *data = dev_get_drvdata(dev);
>
> I can't help but think that toggle is a confusing name for this.
> enable?
>
If I recall correctly we had this argument before. Problem is that the
function can also _disable_ the alarm, so to name it enable is just
as misleading or confusing. update_alarm, maybe ?

Guenter
