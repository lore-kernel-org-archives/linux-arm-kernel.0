From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 29 Mar 2013 20:34:19 +0100
Subject: [PATCH 1/2] video: ssd1307fb: Add support for SSD1306 OLED
 controller
In-Reply-To: <20130329183842.GH20693@game.jcrosoft.org>
References: <1362588251-1824-1-git-send-email-maxime.ripard@free-electrons.com>
 <1362588251-1824-2-git-send-email-maxime.ripard@free-electrons.com>
 <20130329183842.GH20693@game.jcrosoft.org>
Message-ID: <5155ECBB.9000008@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean Christophe,

Le 29/03/2013 19:38, Jean-Christophe PLAGNIOL-VILLARD a ?crit :
> On 17:44 Wed 06 Mar     , Maxime Ripard wrote:

[snip]

>>  static int ssd1307fb_probe(struct i2c_client *client,
>>  			   const struct i2c_device_id *id)
>>  {
>>  	struct fb_info *info;
>> -	u32 vmem_size = SSD1307FB_WIDTH * SSD1307FB_HEIGHT / 8;
>> +	struct device_node *node = client->dev.of_node;
>> +	u32 vmem_size;
>>  	struct ssd1307fb_par *par;
>>  	u8 *vmem;
>>  	int ret;
>>  
>> -	if (!client->dev.of_node) {
>> +	if (!node) {
> why this will be DT only?
> 
> a platform or ARN that does not support DT can not use this driver
> 
> this looks not right

Because the platform I was developing that for was DT-only, and I guess
if someone wants to use this driver on a non-DT platform, that
hypothetical someone can always send a patch to enable the "old-style"
probing in this driver.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
