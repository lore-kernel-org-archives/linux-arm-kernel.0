From: patrice.chotard@st.com (Patrice Chotard)
Date: Wed, 20 Apr 2016 09:40:15 +0200
Subject: [PATCH 0/8] STMPE fixes/rework and add STMPE1600 support
In-Reply-To: <5716545D.9080006@wwwdotorg.org>
References: <1461068317-28016-1-git-send-email-patrice.chotard@st.com>
 <5716545D.9080006@wwwdotorg.org>
Message-ID: <5717325F.6080808@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/19/2016 05:53 PM, Stephen Warren wrote:
> On 04/19/2016 06:18 AM, patrice.chotard at st.com wrote:
>> From: Patrice Chotard <patrice.chotard@st.com>
>>
>> This series cleans and fixes some bugs in MFD/GPIO STMPE drivers and 
>> prepare
>>   the ground to add new STMPE1600 support.
>>
>> STMPE1600 datasheet is available here :
>> http://www2.st.com/content/st_com/en/products/interfaces-and-transceivers/ 
>>
>> i-o-expanders-and-level-translators/i-o-expanders/stmpe1600.html
>>
>> Only STMPE1600 has been tested on STM32 platform. As i have no board 
>> with
>> others STMPE 
>> variant(STMPE610/STMPE801/STMPE811/STMPE1601/STMPE1801/STMPE2401
>> and STMPE2403), i put in CC boards's maintainers which are using 
>> others STMPE variant.
>>
>> If they can kindly check that no regression has been introduce by 
>> this series
>
>> For TEGRA ARCHITECTURE SUPPORT
>>     _ Stephen Warren <swarren@wwwdotorg.org>
>>     _ Thierry Reding <thierry.reding@gmail.com>
>>     _ Alexandre Courbot <gnurou@gmail.com>
>
> I don't know what STMPE is, and I don't believe it is used on Tegra; 
> what makes you think it is?

Hi Stephen

STMPE family is GPIO expander, and for some of them, it includes others 
fonctionnality:
     _STMPE811 and STMPE610: touchscreen controller
     _ STMPE1601, STMPE2401 and STMPE2403: keypad and PWM controller
     _ STMPE1801: keypad controller

For more informations, some datasheets are available here: 
http://www2.st.com/content/st_com/en/products/interfaces-and-transceivers/i-o-expanders-and-level-translators/i-o-expanders.html?querycriteria=productId=SC1027

drivers/mfd/stmpe.c and drivers/gpio/gpio-stmpe.c are drivers which 
support all STMPE variant.
I put you in copy as STMPE811 is used on tegra30-apalis and 
tegra30-colibri platforms.

Thanks

Patrice
