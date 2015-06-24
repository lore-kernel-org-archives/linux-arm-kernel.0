From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed, 24 Jun 2015 10:52:38 +0100
Subject: [PATCH v6 3/9] nvmem: Add nvmem_device based consumer apis.
In-Reply-To: <1344600420.252283.1435091331020.JavaMail.open-xchange@oxbsltgw00.schlund.de>
References: <1435014459-26138-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1435014527-26265-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1344600420.252283.1435091331020.JavaMail.open-xchange@oxbsltgw00.schlund.de>
Message-ID: <558A7DE6.9060000@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 23/06/15 21:28, Stefan Wahren wrote:
>> >@@ -26,6 +35,21 @@ void devm_nvmem_cell_put(struct device *dev, struct
>> >nvmem_cell *cell);
>> >void *nvmem_cell_read(struct nvmem_cell *cell, ssize_t *len);
>> >int nvmem_cell_write(struct nvmem_cell *cell, void *buf, ssize_t len);
>> >
>> >+/* direct nvmem device read/write interface */
>> >+struct nvmem_device *nvmem_device_get(struct device *dev, const char *name);
>> >+struct nvmem_device *devm_nvmem_device_get(struct device *dev,
>> >+ const char *name);
>> >+void nvmem_device_put(struct nvmem_device *nvmem);
>> >+void devm_nvmem_device_put(struct device *dev, struct nvmem_device *nvmem);
>> >+int nvmem_device_read(struct nvmem_device *nvmem, unsigned int offset,
>> >+ size_t bytes, void *buf);
>> >+int nvmem_device_write(struct nvmem_device *nvmem, unsigned int offset,
>> >+ size_t bytes, void *buf);
> Maybe i mixed something but those functions use the datatype unsigned int for
> offset
> and the offset in the structs use datatype int. Looks a little bit inconsistent.
thanks for comments,

I will have a relook at this and see if I can fix it.

thanks,
srini
